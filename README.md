# uImage-header-extractor

a tool to extract info from uImage header


## About the Tool

This is the message after uImage boot up by u-boot. This tool will extract this information from the uImage file.

```
   Image Name:   MIPS OpenWrt Linux-3.10.14
   Image Type:   MIPS Linux Kernel Image (lzma compressed)
   Data Size:    1562342 Bytes =  1.5 MB
   Load Address: 80000000
   Entry Point:  80000000
   Verifying Checksum ... OK
```


## How to USE

```
$ ./uImage_header_extractor.sh /path/to/uImage 

00000000  27 05 19 56 35 f4 5a c9  5b 92 65 eb 00 17 d6 d2  |'..V5.Z.[.e.....|
00000010  80 00 00 00 80 00 00 00  78 0e 1b 5b 05 05 02 03  |........x..[....|
00000020  4d 49 50 53 20 4f 70 65  6e 57 72 74 20 4c 69 6e  |MIPS OpenWrt Lin|
00000030  75 78 2d 33 2e 31 30 2e  31 34 00 00 00 00 00 00  |ux-3.10.14......|
00000040

ih_magic (Image Header Magic Number)     0x27051956                        
ih_hcrc  (Image Header CRC Checksum)     0x35f45ac9                        
ih_time  (Image Creation Timestamp)      0x5b9265eb                        (Fri Sep  7 19:50:03 CST 2018)
ih_size  (Image Data Size)               0x0017d6d2                        (1562322 bytes)
ih_load  (Data Load Address)             0x80000000                        
ih_ep    (Entry Point Address)           0x80000000                        
ih_dcrc  (Image Data CRC Checksum)       0x780e1b5b                        
ih_os    (Operating System)              0x05                              (Linux)
ih_arch  (CPU architecture)              0x05                              (MIPS)
ih_type  (Image Type)                    0x02                              (OS Kernel Image)
ih_comp  (Compression Type)              0x03                              (lzma Compression)
ih_name  (Image Name)                    MIPS OpenWrt Linux-3.10.14

Verifying Magic Number...PASS
Verifying Checksum...PASS
```

~ END ~