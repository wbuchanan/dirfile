# DIRFILE

Utility using recursive descent to remove files and subdirectories.  Intended for use with the `brewscheme` toolkit available (here)[https://github.com/wbuchanan/brewscheme/].

# Examples
Shows an example where you want to recursively delete files and subdirectories.  Each file encountered triggers a prompt allowing the user to determine whether or not they would like to delete the file and/or subdirectory.  


```Stata

// Show test subdirectory to show how program works
. ls test

total 0
drwxr-xr-x  4 billy  wheel  136 Nov  9 05:52 subdir1/
drwxr-xr-x  4 billy  wheel  136 Nov  9 05:52 subdir2/
drwxr-xr-x  4 billy  wheel  136 Nov  9 05:52 subdir3/
drwxr-xr-x  2 billy  wheel   68 Nov  9 05:52 subdir4/
drwxr-xr-x  4 billy  wheel  136 Nov  9 05:52 subdir5/

// Show files in subdirectory 1
. ls test/subdir1

total 0
-rw-r--r--  1 billy  wheel  0 Nov  9 05:52 testfile1.txt
-rw-r--r--  1 billy  wheel  0 Nov  9 05:52 testfile2.txt

// Show files in subdirectory 2
. ls test/subdir2

total 0
-rw-r--r--  1 billy  wheel  0 Nov  9 05:52 testfile1.txt
-rw-r--r--  1 billy  wheel  0 Nov  9 05:52 testfile2.txt

// Show files in subdirectory 3
. ls test/subdir3

total 0
-rw-r--r--  1 billy  wheel  0 Nov  9 05:52 testfile1.txt
-rw-r--r--  1 billy  wheel  0 Nov  9 05:52 testfile2.txt

// Show files in subdirectory 4
// Note the program handles empty subdirectories as well
. ls test/subdir4

// Show files in subdirectory 5
. ls test/subdir5

total 0
-rw-r--r--  1 billy  wheel  0 Nov  9 05:52 testfile1.txt
-rw-r--r--  1 billy  wheel  0 Nov  9 05:52 testfile2.txt

// Calls the program pointing at the test subdirectory listed above
. dirfile `c(pwd)', p(test) reb
Delete the file testfile1.txt from /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir1? (Y/n). y
Erased the file : /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir1/testfile1.txt
Delete the file testfile2.txt from /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir1? (Y/n). y
Erased the file : /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir1/testfile2.txt
/Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir1 is empty.  Delete the directory too? (Y/n). y
Delete the file testfile1.txt from /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir2? (Y/n). y
Erased the file : /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir2/testfile1.txt
Delete the file testfile2.txt from /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir2? (Y/n). y
Erased the file : /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir2/testfile2.txt
/Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir2 is empty.  Delete the directory too? (Y/n). y
Delete the file testfile1.txt from /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir3? (Y/n). y
Erased the file : /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir3/testfile1.txt
Delete the file testfile2.txt from /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir3? (Y/n). y
Erased the file : /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir3/testfile2.txt
/Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir3 is empty.  Delete the directory too? (Y/n). y
/Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir4 is empty.  Delete the directory too? (Y/n). y
Delete the file testfile1.txt from /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir5? (Y/n). y
Erased the file : /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir5/testfile1.txt
Delete the file testfile2.txt from /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir5? (Y/n). y
Erased the file : /Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir5/testfile2.txt
/Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test/subdir5 is empty.  Delete the directory too? (Y/n). y
/Users/billy/Desktop/Programs/StataPrograms/d/dirfile/test is empty.  Delete the directory too? (Y/n). y

. ls

total 24
-rw-r--r--  1 billy  wheel   137 Oct 27  2015 README.md
-rw-r--r--@ 1 billy  wheel  4129 Nov  9 05:52 dirfile.ado

```





