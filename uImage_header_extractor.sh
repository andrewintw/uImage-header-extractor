#! /bin/sh
# -----------------------------------
# Andrew Lin (yenchang.lin@gmail.com)
# -----------------------------------

FWIMG=$1
IH_MAGIC="27051956"

ih_magic=0
ih_hcrc=0
ih_time=0
ih_time_dc=0
ih_size=0
ih_size_dc=0
ih_load=0
ih_ep=0
ih_dcrc=0
ih_os=0
ih_arch=0
ih_type=0
ih_comp=0
ih_name=''

_get_os () {
#define IH_OS_INVALID   0   /* Invalid OS   */
#define IH_OS_OPENBSD   1   /* OpenBSD  */
#define IH_OS_NETBSD    2   /* NetBSD   */
#define IH_OS_FREEBSD   3   /* FreeBSD  */
#define IH_OS_4_4BSD    4   /* 4.4BSD   */
#define IH_OS_LINUX     5   /* Linux    */
#define IH_OS_SVR4      6   /* SVR4     */
#define IH_OS_ESIX      7   /* Esix     */
#define IH_OS_SOLARIS   8   /* Solaris  */
#define IH_OS_IRIX      9   /* Irix     */
#define IH_OS_SCO       10  /* SCO      */
#define IH_OS_DELL      11  /* Dell     */
#define IH_OS_NCR       12  /* NCR      */
#define IH_OS_LYNXOS    13  /* LynxOS   */
#define IH_OS_VXWORKS   14  /* VxWorks  */
#define IH_OS_PSOS      15  /* pSOS     */
#define IH_OS_QNX       16  /* QNX      */
#define IH_OS_U_BOOT    17  /* Firmware */
#define IH_OS_RTEMS     18  /* RTEMS    */
#define IH_OS_ARTOS     19  /* ARTOS    */
#define IH_OS_UNITY     20  /* Unity OS */
	local ih_os="$1"
	case "$ih_os" in
		"00")	echo "Invalid OS" 	;;
		"01")	echo "OpenBSD" 		;;
		"02")	echo "NetBSD"		;;
		"03")	echo "FreeBSD"		;;
		"04")	echo "4.4BSD"		;;
		"05")	echo "Linux"		;;
		"06")	echo "SVR4"			;;
		"07")	echo "Esix"			;;
		"08")	echo "Solaris"		;;
		"09")	echo "Irix"			;;
		"10")	echo "SCO"			;;
		"11")	echo "Dell"			;;
		"12")	echo "NCR"			;;
		"13")	echo "LynxOS"		;;
		"14")	echo "VxWorks"		;;
		"15")	echo "pSOS"			;;
		"16")	echo "QNX"			;;
		"17")	echo "Firmware"		;;
		"18")	echo "RTEMS"		;;
		"19")	echo "ARTOS"		;;
		"20")	echo "Unity OS"		;;
		*)		echo "ERROR OS"		;;
	esac
}

_get_arch () {
#define IH_CPU_INVALID      0   /* Invalid CPU  */
#define IH_CPU_ALPHA        1   /* Alpha        */
#define IH_CPU_ARM          2   /* ARM          */
#define IH_CPU_I386         3   /* Intel x86    */
#define IH_CPU_IA64         4   /* IA64         */
#define IH_CPU_MIPS         5   /* MIPS         */
#define IH_CPU_MIPS64       6   /* MIPS  64 Bit */
#define IH_CPU_PPC          7   /* PowerPC      */
#define IH_CPU_S390         8   /* IBM S390     */
#define IH_CPU_SH           9   /* SuperH       */
#define IH_CPU_SPARC        10  /* Sparc        */
#define IH_CPU_SPARC64      11  /* Sparc 64 Bit */
#define IH_CPU_M68K         12  /* M68K         */
#define IH_CPU_NIOS         13  /* Nios-32      */
#define IH_CPU_MICROBLAZE   14  /* MicroBlaze   */
#define IH_CPU_NIOS2        15  /* Nios-II      */
	local ih_arch="$1"
	case "$ih_arch" in
		"00")	echo "Invalid CPU"	;;
		"01")	echo "Alpha"		;;
		"02")	echo "ARM"			;;
		"03")	echo "Intel x86"	;;
		"04")	echo "IA64"			;;
		"05")	echo "MIPS"			;;
		"06")	echo "MIPS 64 Bit"	;;
		"07")	echo "PowerPC"		;;
		"08")	echo "IBM S390"		;;
		"09")	echo "SuperH"		;;
		"10")	echo "Sparc"		;;
		"11")	echo "Sparc 64 Bit"	;;
		"12")	echo "M68K"			;;
		"13")	echo "Nios-32"		;;
		"14")	echo "MicroBlaze"	;;
		"15")	echo "Nios-II"		;;
		*)		echo "ERROR ARCH"	;;
	esac
}

_get_comp () {
#define IH_COMP_NONE    0   /*  No   Compression Used   */
#define IH_COMP_GZIP    1   /* gzip  Compression Used   */
#define IH_COMP_BZIP2   2   /* bzip2 Compression Used   */
#define IH_COMP_LZMA    3   /* lzma Compression Used    */
#define IH_COMP_XZ      5   /* xz    Compression Used   */
	local ih_comp="$1"
	case "$ih_comp" in
		"00")	echo "No Compression"		;;
		"01")	echo "gzip Compression"		;;
		"02")	echo "bzip2 Compression"	;;
		"03")	echo "lzma Compression"		;;
		"05")	echo "xz Compression"		;;
		*)		echo "ERROR COMP"			;;
	esac
}

_get_type () {
#define IH_TYPE_INVALID     0   /* Invalid Image        */
#define IH_TYPE_STANDALONE  1   /* Standalone Program   */
#define IH_TYPE_KERNEL      2   /* OS Kernel Image      */
#define IH_TYPE_RAMDISK     3   /* RAMDisk Image        */
#define IH_TYPE_MULTI       4   /* Multi-File Image     */
#define IH_TYPE_FIRMWARE    5   /* Firmware Image       */
#define IH_TYPE_SCRIPT      6   /* Script file          */
#define IH_TYPE_FILESYSTEM  7   /* Filesystem Image (any type)  */

	local ih_type="$1"
	case "$ih_type" in
		"00")	echo "Invalid Image"				;;
		"01")	echo "Standalone Program"			;;
		"02")	echo "OS Kernel Image"				;;
		"03")	echo "RAMDisk Image"				;;
		"04")	echo "Multi-File Image"				;;
		"05")	echo "Firmware Image"				;;
		"06")	echo "Script file"					;;
		"07")	echo "Filesystem Image (any type)"	;;
		*)		echo "ERROR TYPE"					;;
	esac
}

do_init () {
	if [ "$FWIMG" = "" ]; then
		echo "Usage: $0 </path/to/firmware>"
		exit 1
	fi

	if [ ! -f "$FWIMG" ]; then
		echo "ERROR: $FWIMG does not exists"
		exit 1
	fi
}

extract_info () {
#typedef struct image_header {
#    uint32_t    ih_magic;   /* Image Header Magic Number    */
#    uint32_t    ih_hcrc;    /* Image Header CRC Checksum    */
#    uint32_t    ih_time;    /* Image Creation Timestamp */
#    uint32_t    ih_size;    /* Image Data Size      */
#    uint32_t    ih_load;    /* Data  Load  Address      */
#    uint32_t    ih_ep;      /* Entry Point Address      */
#    uint32_t    ih_dcrc;    /* Image Data CRC Checksum  */
#    uint8_t     ih_os;      /* Operating System     */ => IH_OS_LINUX
#    uint8_t     ih_arch;    /* CPU architecture     */ => IH_CPU_MIPS
#    uint8_t     ih_type;    /* Image Type           */ => IH_TYPE_KERNEL
#    uint8_t     ih_comp;    /* Compression Type     */ => IH_COMP_LZMA
#    uint8_t     ih_name[32];  /* Image Name       */
#} image_header_t;
#
	ih_magic="`hexdump -s  0 -n  4  -e '16/1 "%02x"' $FWIMG`"
	ih_hcrc="`hexdump  -s  4 -n  4  -e '16/1 "%02x"' $FWIMG`"
	ih_time="`hexdump  -s  8 -n  4  -e '16/1 "%02x"' $FWIMG`"
	ih_size="`hexdump  -s 12 -n  4  -e '16/1 "%02x"' $FWIMG`"
	ih_load="`hexdump  -s 16 -n  4  -e '16/1 "%02x"' $FWIMG`"
	ih_ep="`hexdump    -s 20 -n  4  -e '16/1 "%02x"' $FWIMG`"
	ih_dcrc="`hexdump  -s 24 -n  4  -e '16/1 "%02x"' $FWIMG`"
	ih_os="`hexdump    -s 28 -n  1  -e '16/1 "%02x"' $FWIMG`"
	ih_arch="`hexdump  -s 29 -n  1  -e '16/1 "%02x"' $FWIMG`"
	ih_type="`hexdump  -s 30 -n  1  -e '16/1 "%02x"' $FWIMG`"
	ih_comp="`hexdump  -s 31 -n  1  -e '16/1 "%02x"' $FWIMG`"
	ih_name="`hexdump  -s 32 -n 32  -e '16/1 "%c"'	$FWIMG`"
}

hexdump_header () {
	echo ""
	hexdump -n 64 -C $FWIMG
}

display_info () {
	ih_time_dc=`echo "obase=10; ibase=16; $(echo $ih_time | tr '[:lower:]' '[:upper:]')" | bc`
	ih_size_dc=`echo "obase=10; ibase=16; $(echo $ih_size | tr '[:lower:]' '[:upper:]')" | bc`

	echo ""
	printf '%-40s %-10s\n'	"ih_magic (Image Header Magic Number)"		"0x${ih_magic}"
	printf '%-40s %-10s\n'	"ih_hcrc  (Image Header CRC Checksum)"		"0x${ih_hcrc}"
	printf '%-40s %-10s'	"ih_time  (Image Creation Timestamp)"		"0x${ih_time}"
																		echo "(`date -d @${ih_time_dc}`)"

	printf '%-40s %-10s'	"ih_size  (Image Data Size)"				"0x${ih_size}"
																		echo "(${ih_size_dc} bytes)"

	printf '%-40s %-10s\n'	"ih_load  (Data Load Address)"				"0x${ih_load}"
	printf '%-40s %-10s\n'	"ih_ep    (Entry Point Address)"			"0x${ih_ep}"
	printf '%-40s %-10s\n'	"ih_dcrc  (Image Data CRC Checksum)"		"0x${ih_dcrc}"

	printf '%-40s %-10s'	"ih_os    (Operating System)"		"0x${ih_os}"
																echo "(`_get_os $ih_os`)"

	printf '%-40s %-10s'	"ih_arch  (CPU architecture)"		"0x${ih_arch}"
																echo "(`_get_arch $ih_arch`)"

	printf '%-40s %-10s'	"ih_type  (Image Type)"				"0x${ih_type}"
																echo "(`_get_type $ih_type`)"

	printf '%-40s %-10s'	"ih_comp  (Compression Type)"		"0x${ih_comp}"
																echo "(`_get_comp $ih_comp`)"

	printf '%-40s '			"ih_name  (Image Name)"
	echo "$ih_name"
	echo ""

#	cat << EOF
#	ih_magic=$ih_magic
#	ih_hcrc=$ih_hcrc
#	ih_time=$ih_time
#	ih_size=$ih_size
#	ih_load=$ih_load
#	ih_ep=$ih_ep
#	ih_dcrc=$ih_dcrc
#	ih_os=$ih_os
#	ih_arch=$ih_arch
#	ih_type=$ih_type
#	ih_comp=$ih_comp
#	ih_name=$ih_name
#EOF
}

_verify_kernel_crc() {
	local tmp_kernel=_${FWING}.kernel
	local tmp_kernel_crc=0

	dd if=$FWIMG of=$tmp_kernel skip=64 bs=1 count=$ih_size_dc status=none

	if [ -f "$tmp_kernel" ]; then
		tmp_kernel_crc=`crc32 $tmp_kernel`
		rm -rf $tmp_kernel
	fi

	if [ $ih_dcrc = $tmp_kernel_crc ]; then
		echo 0
	else
		echo 1
	fi
}

verify_info () {
	echo -n "Verifying Magic Number..."
	if [ "$ih_magic" -eq $IH_MAGIC ]; then
		echo "PASS"
	else
		echo "FAILE"
		echo "This is NOT an uimage"
		exit 1
	fi

	echo -n "Verifying Checksum..."
	if [ "`_verify_kernel_crc`" = "0" ]; then
		echo "PASS"
	else
		echo "FAILE"
		exit 1
	fi
}

do_main () {
	do_init
	hexdump_header
	extract_info
	display_info
	verify_info
}

do_main
echo ""
