#/bin/bash
#by benjaminwan V0.2
printf "**************************************\n"
printf "please put this shell to system folder\n"
printf "**************************************\n"

function getNeed()
{
    echo '<<<<<<getting NEED for '$1'>>>>>>'
    case $1 in
      lib/egl)
        name=lib_egl
        ;;
      lib/hw)
        name=lib_hw
        ;;
      lib/soundfx)
        name=soundfx
        ;;
      vendor/bin)
        name=vendor_bin
        ;;
      vendor/lib)
        name=vendor_lib
        ;;
      vendor/firmware)
        name=vendor_lib_firmware
        ;;
      vendor/lib/egl)
        name=vendor_lib_egl
        ;;
      vendor/lib/hw)
        name=vendor_lib_hw
        ;;
      *)
        name=$1
        ;;
    esac

    if [ ! -d $1 ];then
        printf "can't find $1 folder!\n"
    else
        ls $1 -p | grep [^/]$ > info_$name.txt
        cat info_$name.txt |while read line
        do
            echo "getting NEED for" $line
            echo $line >> Need_$name.txt
            objdump -x $1/$line | grep "NEEDED" >> Need_$name.txt
            echo "*************************************" >> Need_$name.txt
        done
        rm info_$name.txt
    fi
}

getNeed bin;
getNeed xbin;
getNeed lib;
getNeed lib/egl;
getNeed lib/hw;
getNeed lib/soundfx;
getNeed vendor/bin;
getNeed vendor/lib;
getNeed vendor/firmware;
getNeed vendor/lib/egl;
getNeed vendor/lib/hw;
printf "**********Completed!**********\n"
