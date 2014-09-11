This repo contains the source code for a talk on bash scripting.

## dependencies
- unpaper
- tesseract
- libtiff
- poppler
- netpbm

## usage

    ./process_document_dir.sh ~/documents/pdfs

The script takes a single directory as an argument,  expecting its structure to be:

    pdfs:
        pdfname:
            1.pdf
            a.pdf
            b.pdf
        secondpdfname:
            aasdjsad.pdf
            asdsafsafasfsa.pdf

The script will collate the pdfs in each directory, combine them, ocr them, and add the ocr text to the pdf.  The above example will output two pdfs into "pdfs" named pdfname.pdf and secondpdfname.pdf, each containing the pdfs from their respective directories.
