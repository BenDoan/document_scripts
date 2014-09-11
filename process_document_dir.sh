#!/usr/bin/bash

dir=$1
tmp=/tmp/document_process
rm -rf $tmp
mkdir $tmp

for d in $dir/*; do
    if [ -d $d ]; then
        NUM=1
        for pdf in $d/*.pdf; do
            echo "Converting #$NUM to pgm"
            pdftoppm -gray $pdf $tmp/document$NUM'temp-page'
            NUM=$(($NUM + 1))
        done

        for i in $tmp/*.pgm; do
            unpaper $i ${i}un
            pnmtotiff ${i}un > ${i}un.tiff
        done

        tiffcp $tmp/*.tiff $tmp/all.tiff

        tiff2pdf -z -o $dir/$(basename $d).pdf $tmp/all.tiff
    fi
    rm $tmp/* > /dev/null 2>&1
done

echo "Starting OCR"

for p in $dir/*.pdf; do
    pdftoppm -gray $p $tmp/ocr-temp

    for x in $tmp/ocr-temp*.pgm; do
        tesseract $x $tmp/outputtext hocr
        hocr2pdf -i $x -o $x'.pdf' < $tmp/outputtext.hocr
        rm $x
    done

    pdfunite $tmp/*.pdf $dir/parsed-$(basename $p)
    rm $tmp/*
done

rm -rf $tmp
