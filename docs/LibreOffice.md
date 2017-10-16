# LibreOffice

LibreOffice's default options are not always what I want, and custom settings (used to?) get lost after installing an upgrade. This is an overview of my local changes to the defaults.

## Font substitution

MS Office documents that use the Calibri and Cambria fonts look horrible in LibreOffice.

1. Install fonts Carlito and Caladea

    ```ShellSession
    $ sudo dnf install google-crosextra-caladea-fonts.noarch \
        google-crosextra-carlito-fonts.noarch
    ```
2. In LibreOffice, open Tools > Options > Fonts
3. Enable "Apply replacement table"
4. Font "Calibri", replace with "Carlito"
5. Font "Cambria", replace with "Caladea"
6. Check the boxes in the column "Always"

Source: <https://wiki.debian.org/SubstitutingCalibriAndCambriaFonts>

## Custom keyboard shortcuts

In Impress, Tools > Customize > Keyboard

| Keyboard Shortcut | Category | Function |
| :---              | :---     | :---     |
| `Ctrl-PgDn`       | Insert   | Slide    |

## Custom colours

The LibreOffice colour palette is loaded from an XML file in `~/.config/libreoffice/4/user/config/standard.soc`. To add custom colours, it's best to add them once using the GUI (Tools > Options > Colors) and save them separately. To load your custom colours later, load the colour file.

If you only want to add some colours, copy/paste the XML code defining those colours into `standard.soc`.

Custom colours for HoGent:

```XML
<draw:color draw:name="HoGentAccent1" draw:color="#c7c9cb"/>
<draw:color draw:name="HoGentAccent2" draw:color="#fff000"/>
<draw:color draw:name="HoGentAccent3" draw:color="#ffac87"/>
<draw:color draw:name="HoGentAccent4" draw:color="#ffe916"/>
<draw:color draw:name="HoGentAccent5" draw:color="#ff7477"/>
<draw:color draw:name="HoGentAccent6" draw:color="#78e6d0"/>
<draw:color draw:name="HoGentCVO" draw:color="#ff521d"/>
<draw:color draw:name="HoGentFMW" draw:color="#009c7c"/>
<draw:color draw:name="HoGentFNT" draw:color="#f43445"/>
<draw:color draw:name="HoGentFBO" draw:color="#006fb8"/>
<draw:color draw:name="HoGentSOA" draw:color="#000000"/>
```
