# aarch64-asm-linux

Kompilasi kode assembly aarch64 di linux.

## Fungsi yang sudah ada dalam proyek ini

File io.s:
- print, untuk mencetak teks ke layar
- println, untuk mencetak teks ke layar dengan baris baru
- printReverse, untuk mencetak teks dengan urutan terbalik ke layar (dengan baris baru)
- printInt, untuk mencetak bilangan bulat ke layar
- printHex, untuk mencetak nilai ke layar sebagai heksadesimal
- printBin, untuk mencetak nilai ke layar sebagai biner
- inputSTDIN, untuk mengambil input dari standard input (keyboard)
- exit, untuk menghentikan program (keluar dengan normal)

File utils.s:
- str2UInt, untuk mengubah string ke bilangan bulat positif
- strBin2UInt, untuk mengubah string biner ke bilangan bulat positif
- toUpper, untuk mengubah string ke upper-case

File list.s:
- ladd, untuk menambahkan item ke dalam list.
- lprint, untuk mencetak semua item dalam list.
- lget, untuk mendapatkan item dari list (indeks dimulai dari 0).
