********************************************************************************
* Description of the Program -												   *
* Utility for checking/handling directory construction/management related to   *
* brewscheme.																   *
*                                                                              *
* Data Requirements -														   *
*     none                                                                     *
*																			   *
* System Requirements -														   *
*     Active Internet Connection											   *
*                                                                              *
* Program Output -                                                             *
*     void																	   *
*                                                                              *
* Lines -                                                                      *
*     204                                                                      *
*                                                                              *
********************************************************************************
		
*! dirfile
*! v 0.0.8
*! 21FEB2020

// Drop the program from memory if loaded
cap prog drop dirfile

// Define the file
prog def dirfile

	// Interpret under Stata version 13
	version 13
	
	// Syntax for calling the program
	syntax [anything(name = root id = "Root directory")], [ Path(string) REBuild ]
	
	// Test whether there are sufficient arguments to allow the program to work
	if `"`root'`path'"' == "" {
	
		// If no root and path specified let the user know that it is an issue
		di as err "Must provide a root directory and/or a path to search for"
		
		// Return an error code
		err 198
		
	} // End of IF Block for invalid arguments
	
	// If no root is specified it needs to be parsed
	else if `"`root'"' == "" & `"`path'"' != "" {
	
		// Defines a container to store the root value from the path macro
		mata: root = ""
		
		// Stores a new version of the path value that only contains the 
		// subdirectory of interest
		mata: path = ""
		
		// Splits the path value into component parts
		mata: pathsplit(st_local("path"), root, path)
		
		// Sets the value of the root macro
		mata: st_local("root", root)
		
		// Sets the value of the path macro to the subdirectory of interest
		mata: st_local("path", path)
		
	} // End ELSEIF Block to parse a value pased only to path
	
	// Default value for path parameter
	if `"`path'"' == "" loc pmatch "*"
	
	// Passes the value from the path parameter to be used in extended macro function
	else loc pmatch `path'
	
	// Use the path argument for the root if no root is specified with wildcard
	qui: loc newfile : dir "`root'" dirs "`pmatch'", respectcase
	
	// Clean up quotation marks
	loc newfile : list clean newfile

	// Doesn't exist create it
	if `"`newfile'"' == "" mkdir `"`root'/`path'"'
	
	// Does exist and user wants to rebuild the directory
	else if `"`newfile'"' != "" & "`rebuild'" != "" chksubdir `root'/`newfile'
			
	// If directory exists but user does not want to rebuild	
	else di as res "Directory exists and rebuild option not specified.  No further action"
				
// End of program definition		
end 


// Defines subroutine to check for files in subdirectories and remove them
prog def chksubdir

	// Defines syntax for calling the subroutine
	syntax anything(name = subdirnm id = "Subdirectory name") [, ALL] 
	
	// Test if the all parameter was passed
	if `"`all'"' == "all" {
		
		// Check for filenames
		loc filenames : dir `"`subdirnm'"' files "*", respectcase

		// Loop over the filenames
		foreach v of loc filenames {
			
			// Remove each file
			erase `"`subdirnm'/`v'"'
			
		} // End Loop over file names
		
		// Remove the subdirectory being checked
		qui: rmdir `"`subdirnm'"'
				
	} // End IF Block for case where all parameter is passed

	// If the all Parameter is not set
	else {
		
		// Check for any subdirectories
		loc dirfiles : dir `"`subdirnm'"' dir "*", respectcase
		
		// If there are subdirectories
		if `: word count `dirfiles'' > 0 {
		
			// Loop over subdirectories
			forv d = 1/`: word count `dirfiles'' {
			
				// Call the subroutine recursively
				chksubdir `subdirnm'/`: word `d' of `dirfiles''
				
			} // Loop over the subdirectories
			
		} // End IF Block for subdirectory recursion
			
		// Check for filenames
		loc filenames : dir `"`subdirnm'"' files "*", respectcase
		
		// Test if the subdirectory contains any files
		if `: word count `filenames'' > 0 {
			
			// Print message to screen and get user input
			di as res `"Delete `subdirnm' and its contents? (Y/n)"' _request(_del)

			// Check for potential "all" values
			if inlist(`"`del'"', "y", "Y", "") {
				
				// Recurse into the subroutine with the all parameter set
				chksubdir `subdirnm', all
				
			} // End of ELSEIF block to handle delete all files
			
			// Otherwise iterate through individual files
			else {
				
				// Loop over the files in the directory
				forv i = 1/`: word count `filenames'' {
				
					// Stores the individual file name to check/test
					loc filenm `: word `i' of `filenames''
				
					// Print message to screen and get user input
					di as res `"Delete the file `filenm' from `subdirnm'? (Y/n)"' _request(_del)
					
					// If user enters nothing, y, or Y delete the file
					if inlist(`"`del'"', "y", "Y", "") {
					
						// Erase the file from the disk
						erase `"`subdirnm'/`filenm'"'
						
						// Success message to console
						di as res `"Erased the file : `subdirnm'/`filenm'"'
						
					} // End IF Block for user selected file deletion
					
				} // End Loop over files in directory
				
			} // End ELSE Block to iterate over individual files
			
		} // End IF BLOCK for subdirectories with files
		
		// Check for any subdirectories
		cap loc dirfiles : dir `"`subdirnm'"' dir "*", respectcase

		// Check for filenames
		cap loc filenames : dir `"`subdirnm'"' files "*", respectcase
		
		// If the directory is empty 
		if `"`dirfiles'`filenames'"' == "" {

			// Ask user if they want to delete the directory
			di as res `"`subdirnm' is empty.  Delete the directory too? (Y/n)"'  ///   
			_request(_del)

			// If y, Y, or null delete the directory
			if inlist(`"`del'"', "y", "Y") qui: rmdir `"`subdirnm'"'
				
		} // End IF Block for directory removal

	} // End ELSE Block for inital call and iteration over files
	
// End of subroutine	
end

