;;; ttx-mode-tests.el --- ERT tests for ttx-mode -*- lexical-binding: t; -*-

;;; Code:

(require 'ert)
(require 'ttx-mode)

(defconst ttx-test-font-ttf
  (expand-file-name "testdata/NotoSansTest-Regular.ttf"
                    (file-name-directory (or load-file-name buffer-file-name))))

(defconst ttx-test-font-woff2
  (expand-file-name "testdata/NotoSansTest-Regular.woff2"
                    (file-name-directory (or load-file-name buffer-file-name))))

(defconst ttx-test-font-ttf-as-ttx
  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<ttFont>
  <!-- Available tables (use ttx-load-table to load): -->
  <!-- OS/2 (96B) -->
  <!-- cmap (60B) -->
  <!-- glyf (832B) -->
  <!-- head (54B) -->
  <!-- hhea (36B) -->
  <!-- hmtx (16B) -->
  <!-- loca (10B) -->
  <!-- maxp (32B) -->
  <!-- name (1.2KiB) -->
  <!-- post (58B) -->
</ttFont>
")

(defconst ttx-test-font-ttf-as-ttx-with-head
  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<ttFont>
  <!-- Available tables (use ttx-load-table to load): -->
  <!-- OS/2 (96B) -->
  <!-- cmap (60B) -->
  <!-- glyf (832B) -->
  <!-- head (54B) -->
  <!-- hhea (36B) -->
  <!-- hmtx (16B) -->
  <!-- loca (10B) -->
  <!-- maxp (32B) -->
  <!-- name (1.2KiB) -->
  <!-- post (58B) -->


  <head>
    <!-- Most of this table will be recalculated by the compiler -->
    <tableVersion value=\"1.0\"/>
    <fontRevision value=\"1.002\"/>
    <checkSumAdjustment value=\"0x39376b43\"/>
    <magicNumber value=\"0x5f0f3cf5\"/>
    <flags value=\"00000000 00000011\"/>
    <unitsPerEm value=\"1000\"/>
    <created value=\"Sun Apr  3 17:04:08 2022\"/>
    <modified value=\"Mon Apr 15 09:58:38 2024\"/>
    <xMin value=\"26\"/>
    <yMin value=\"-200\"/>
    <xMax value=\"998\"/>
    <yMax value=\"800\"/>
    <macStyle value=\"00000000 00000000\"/>
    <lowestRecPPEM value=\"6\"/>
    <fontDirectionHint value=\"2\"/>
    <indexToLocFormat value=\"0\"/>
    <glyphDataFormat value=\"0\"/>
  </head>
</ttFont>
")

(defmacro ttx-test-with-font (font-path &rest body)
  "Open FONT-PATH, run BODY, then kill buffer."
  (declare (indent 1))
  `(let* ((buf (find-file-noselect ,font-path)))
     (unwind-protect
         (with-current-buffer buf ,@body)
       (kill-buffer buf))))

(ert-deftest ttx-load-all-tables-loads-all-tables ()
  "Loading all tables produces a buffer with every table present."
  (ttx-test-with-font ttx-test-font-ttf
    (ttx-load-all-tables)
    (should (equal (buffer-string)
                   "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<ttFont>
  <!-- Available tables (use ttx-load-table to load): -->
  <!-- OS/2 (96B) -->
  <!-- cmap (60B) -->
  <!-- glyf (832B) -->
  <!-- head (54B) -->
  <!-- hhea (36B) -->
  <!-- hmtx (16B) -->
  <!-- loca (10B) -->
  <!-- maxp (32B) -->
  <!-- name (1.2KiB) -->
  <!-- post (58B) -->


  <head>
    <!-- Most of this table will be recalculated by the compiler -->
    <tableVersion value=\"1.0\"/>
    <fontRevision value=\"1.002\"/>
    <checkSumAdjustment value=\"0x39376b43\"/>
    <magicNumber value=\"0x5f0f3cf5\"/>
    <flags value=\"00000000 00000011\"/>
    <unitsPerEm value=\"1000\"/>
    <created value=\"Sun Apr  3 17:04:08 2022\"/>
    <modified value=\"Mon Apr 15 09:58:38 2024\"/>
    <xMin value=\"26\"/>
    <yMin value=\"-200\"/>
    <xMax value=\"998\"/>
    <yMax value=\"800\"/>
    <macStyle value=\"00000000 00000000\"/>
    <lowestRecPPEM value=\"6\"/>
    <fontDirectionHint value=\"2\"/>
    <indexToLocFormat value=\"0\"/>
    <glyphDataFormat value=\"0\"/>
  </head>


  <name>
    <namerecord nameID=\"0\" platformID=\"3\" platEncID=\"1\" langID=\"0x409\">
      Copyright 2022 Google Inc. All Rights Reserved.
    </namerecord>
    <namerecord nameID=\"1\" platformID=\"3\" platEncID=\"1\" langID=\"0x409\">
      Noto Sans Test
    </namerecord>
    <namerecord nameID=\"2\" platformID=\"3\" platEncID=\"1\" langID=\"0x409\">
      Regular
    </namerecord>
    <namerecord nameID=\"3\" platformID=\"3\" platEncID=\"1\" langID=\"0x409\">
      1.002;NONE;NotoSansTest-Regular
    </namerecord>
    <namerecord nameID=\"4\" platformID=\"3\" platEncID=\"1\" langID=\"0x409\">
      Noto Sans Test Regular
    </namerecord>
    <namerecord nameID=\"5\" platformID=\"3\" platEncID=\"1\" langID=\"0x409\">
      Version 1.002
    </namerecord>
    <namerecord nameID=\"6\" platformID=\"3\" platEncID=\"1\" langID=\"0x409\">
      NotoSansTest-Regular
    </namerecord>
    <namerecord nameID=\"7\" platformID=\"3\" platEncID=\"1\" langID=\"0x409\">
      Noto is a trademark of Google Inc.
    </namerecord>
    <namerecord nameID=\"13\" platformID=\"3\" platEncID=\"1\" langID=\"0x409\">
      This Font Software is licensed under the SIL Open Font License, Version 1.1. This Font Software is distributed on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the SIL Open Font License for the specific language, permissions and limitations governing your use of this Font Software.
    </namerecord>
    <namerecord nameID=\"14\" platformID=\"3\" platEncID=\"1\" langID=\"0x409\">
      http://scripts.sil.org/OFL
    </namerecord>
  </name>


  <OS_2>
    <!-- The fields 'usFirstCharIndex' and 'usLastCharIndex'
         will be recalculated by the compiler -->
    <version value=\"4\"/>
    <xAvgCharWidth value=\"573\"/>
    <usWeightClass value=\"400\"/>
    <usWidthClass value=\"5\"/>
    <fsType value=\"00000000 00001000\"/>
    <ySubscriptXSize value=\"650\"/>
    <ySubscriptYSize value=\"600\"/>
    <ySubscriptXOffset value=\"0\"/>
    <ySubscriptYOffset value=\"75\"/>
    <ySuperscriptXSize value=\"650\"/>
    <ySuperscriptYSize value=\"600\"/>
    <ySuperscriptXOffset value=\"0\"/>
    <ySuperscriptYOffset value=\"350\"/>
    <yStrikeoutSize value=\"50\"/>
    <yStrikeoutPosition value=\"300\"/>
    <sFamilyClass value=\"0\"/>
    <panose>
      <bFamilyType value=\"0\"/>
      <bSerifStyle value=\"0\"/>
      <bWeight value=\"0\"/>
      <bProportion value=\"0\"/>
      <bContrast value=\"0\"/>
      <bStrokeVariation value=\"0\"/>
      <bArmStyle value=\"0\"/>
      <bLetterForm value=\"0\"/>
      <bMidline value=\"0\"/>
      <bXHeight value=\"0\"/>
    </panose>
    <ulUnicodeRange1 value=\"00000001 00000000 00000000 00000001\"/>
    <ulUnicodeRange2 value=\"00000000 00000000 00000000 00000000\"/>
    <ulUnicodeRange3 value=\"00000000 00000000 00000000 00000000\"/>
    <ulUnicodeRange4 value=\"00000000 00000000 00000000 00000000\"/>
    <achVendID value=\"NONE\"/>
    <fsSelection value=\"00000000 01000000\"/>
    <usFirstCharIndex value=\"32\"/>
    <usLastCharIndex value=\"3697\"/>
    <sTypoAscender value=\"800\"/>
    <sTypoDescender value=\"-200\"/>
    <sTypoLineGap value=\"200\"/>
    <usWinAscent value=\"1000\"/>
    <usWinDescent value=\"200\"/>
    <ulCodePageRange1 value=\"00000000 00000000 00000000 00000001\"/>
    <ulCodePageRange2 value=\"00000000 00000000 00000000 00000000\"/>
    <sxHeight value=\"500\"/>
    <sCapHeight value=\"700\"/>
    <usDefaultChar value=\"0\"/>
    <usBreakChar value=\"32\"/>
    <usMaxContext value=\"0\"/>
  </OS_2>


  <cmap>
    <tableVersion version=\"0\"/>
    <cmap_format_4 platformID=\"0\" platEncID=\"3\" language=\"0\">
      <map code=\"0x20\" name=\"space\"/><!-- SPACE -->
      <map code=\"0xe70\" name=\"uni0E70\"/><!-- ???? -->
      <map code=\"0xe71\" name=\"uni0E71\"/><!-- ???? -->
    </cmap_format_4>
    <cmap_format_4 platformID=\"3\" platEncID=\"1\" language=\"0\">
      <map code=\"0x20\" name=\"space\"/><!-- SPACE -->
      <map code=\"0xe70\" name=\"uni0E70\"/><!-- ???? -->
      <map code=\"0xe71\" name=\"uni0E71\"/><!-- ???? -->
    </cmap_format_4>
  </cmap>


  <glyf>

    <!-- The xMin, yMin, xMax and yMax values
         will be recalculated by the compiler. -->

    <TTGlyph name=\".notdef\" xMin=\"50\" yMin=\"-200\" xMax=\"450\" yMax=\"800\">
      <contour>
        <pt x=\"50\" y=\"-200\" on=\"1\"/>
        <pt x=\"50\" y=\"800\" on=\"1\"/>
        <pt x=\"450\" y=\"800\" on=\"1\"/>
        <pt x=\"450\" y=\"-200\" on=\"1\"/>
      </contour>
      <contour>
        <pt x=\"100\" y=\"-150\" on=\"1\"/>
        <pt x=\"400\" y=\"-150\" on=\"1\"/>
        <pt x=\"400\" y=\"750\" on=\"1\"/>
        <pt x=\"100\" y=\"750\" on=\"1\"/>
      </contour>
      <instructions/>
    </TTGlyph>

    <TTGlyph name=\"space\"/><!-- contains no outline data -->

    <TTGlyph name=\"uni0E70\" xMin=\"26\" yMin=\"-2\" xMax=\"998\" yMax=\"631\">
      <contour>
        <pt x=\"267\" y=\"527\" on=\"1\"/>
        <pt x=\"267\" y=\"518\" on=\"0\"/>
        <pt x=\"267\" y=\"504\" on=\"0\"/>
        <pt x=\"266\" y=\"495\" on=\"1\"/>
        <pt x=\"267\" y=\"495\" on=\"1\"/>
        <pt x=\"273\" y=\"514\" on=\"0\"/>
        <pt x=\"307\" y=\"543\" on=\"0\"/>
        <pt x=\"338\" y=\"543\" on=\"1\"/>
        <pt x=\"370\" y=\"543\" on=\"0\"/>
        <pt x=\"406\" y=\"506\" on=\"0\"/>
        <pt x=\"406\" y=\"467\" on=\"1\"/>
        <pt x=\"406\" y=\"330\" on=\"1\"/>
        <pt x=\"395\" y=\"330\" on=\"1\"/>
        <pt x=\"395\" y=\"467\" on=\"1\"/>
        <pt x=\"395\" y=\"502\" on=\"0\"/>
        <pt x=\"365\" y=\"533\" on=\"0\"/>
        <pt x=\"338\" y=\"533\" on=\"1\"/>
        <pt x=\"306\" y=\"533\" on=\"0\"/>
        <pt x=\"267\" y=\"493\" on=\"0\"/>
        <pt x=\"267\" y=\"450\" on=\"1\"/>
        <pt x=\"267\" y=\"330\" on=\"1\"/>
        <pt x=\"256\" y=\"330\" on=\"1\"/>
        <pt x=\"256\" y=\"631\" on=\"1\"/>
        <pt x=\"267\" y=\"631\" on=\"1\"/>
      </contour>
      <contour>
        <pt x=\"460\" y=\"616\" on=\"1\"/>
        <pt x=\"470\" y=\"616\" on=\"0\"/>
        <pt x=\"470\" y=\"603\" on=\"1\"/>
        <pt x=\"470\" y=\"591\" on=\"0\"/>
        <pt x=\"460\" y=\"591\" on=\"1\"/>
        <pt x=\"450\" y=\"591\" on=\"0\"/>
        <pt x=\"450\" y=\"603\" on=\"1\"/>
        <pt x=\"450\" y=\"616\" on=\"0\"/>
      </contour>
      <contour>
        <pt x=\"816\" y=\"616\" on=\"1\"/>
        <pt x=\"823\" y=\"616\" on=\"0\"/>
        <pt x=\"826\" y=\"608\" on=\"0\"/>
        <pt x=\"826\" y=\"603\" on=\"1\"/>
        <pt x=\"826\" y=\"599\" on=\"0\"/>
        <pt x=\"823\" y=\"591\" on=\"0\"/>
        <pt x=\"816\" y=\"591\" on=\"1\"/>
        <pt x=\"806\" y=\"591\" on=\"0\"/>
        <pt x=\"806\" y=\"603\" on=\"1\"/>
        <pt x=\"806\" y=\"616\" on=\"0\"/>
      </contour>
      <contour>
        <pt x=\"125\" y=\"330\" on=\"1\"/>
        <pt x=\"114\" y=\"330\" on=\"1\"/>
        <pt x=\"114\" y=\"603\" on=\"1\"/>
        <pt x=\"26\" y=\"603\" on=\"1\"/>
        <pt x=\"26\" y=\"613\" on=\"1\"/>
        <pt x=\"213\" y=\"613\" on=\"1\"/>
        <pt x=\"213\" y=\"603\" on=\"1\"/>
        <pt x=\"125\" y=\"603\" on=\"1\"/>
      </contour>
      <contour>
        <pt x=\"641\" y=\"383\" on=\"1\"/>
        <pt x=\"641\" y=\"357\" on=\"0\"/>
        <pt x=\"604\" y=\"326\" on=\"0\"/>
        <pt x=\"567\" y=\"326\" on=\"1\"/>
        <pt x=\"547\" y=\"326\" on=\"0\"/>
        <pt x=\"514\" y=\"335\" on=\"0\"/>
        <pt x=\"503\" y=\"340\" on=\"1\"/>
        <pt x=\"503\" y=\"352\" on=\"1\"/>
        <pt x=\"531\" y=\"336\" on=\"0\"/>
        <pt x=\"567\" y=\"336\" on=\"1\"/>
        <pt x=\"601\" y=\"336\" on=\"0\"/>
        <pt x=\"630\" y=\"361\" on=\"0\"/>
        <pt x=\"630\" y=\"383\" on=\"1\"/>
        <pt x=\"630\" y=\"406\" on=\"0\"/>
        <pt x=\"596\" y=\"427\" on=\"0\"/>
        <pt x=\"571\" y=\"434\" on=\"1\"/>
        <pt x=\"545\" y=\"442\" on=\"0\"/>
        <pt x=\"509\" y=\"463\" on=\"0\"/>
        <pt x=\"509\" y=\"491\" on=\"1\"/>
        <pt x=\"509\" y=\"516\" on=\"0\"/>
        <pt x=\"546\" y=\"543\" on=\"0\"/>
        <pt x=\"577\" y=\"543\" on=\"1\"/>
        <pt x=\"594\" y=\"543\" on=\"0\"/>
        <pt x=\"625\" y=\"536\" on=\"0\"/>
        <pt x=\"637\" y=\"531\" on=\"1\"/>
        <pt x=\"632\" y=\"521\" on=\"1\"/>
        <pt x=\"622\" y=\"527\" on=\"0\"/>
        <pt x=\"592\" y=\"533\" on=\"0\"/>
        <pt x=\"577\" y=\"533\" on=\"1\"/>
        <pt x=\"551\" y=\"533\" on=\"0\"/>
        <pt x=\"520\" y=\"512\" on=\"0\"/>
        <pt x=\"520\" y=\"491\" on=\"1\"/>
        <pt x=\"520\" y=\"467\" on=\"0\"/>
        <pt x=\"553\" y=\"451\" on=\"0\"/>
        <pt x=\"576\" y=\"443\" on=\"1\"/>
        <pt x=\"601\" y=\"435\" on=\"0\"/>
        <pt x=\"641\" y=\"413\" on=\"0\"/>
      </contour>
      <contour>
        <pt x=\"998\" y=\"383\" on=\"1\"/>
        <pt x=\"998\" y=\"357\" on=\"0\"/>
        <pt x=\"961\" y=\"326\" on=\"0\"/>
        <pt x=\"924\" y=\"326\" on=\"1\"/>
        <pt x=\"904\" y=\"326\" on=\"0\"/>
        <pt x=\"870\" y=\"335\" on=\"0\"/>
        <pt x=\"859\" y=\"340\" on=\"1\"/>
        <pt x=\"859\" y=\"352\" on=\"1\"/>
        <pt x=\"887\" y=\"336\" on=\"0\"/>
        <pt x=\"924\" y=\"336\" on=\"1\"/>
        <pt x=\"957\" y=\"336\" on=\"0\"/>
        <pt x=\"986\" y=\"361\" on=\"0\"/>
        <pt x=\"986\" y=\"383\" on=\"1\"/>
        <pt x=\"986\" y=\"406\" on=\"0\"/>
        <pt x=\"952\" y=\"427\" on=\"0\"/>
        <pt x=\"927\" y=\"434\" on=\"1\"/>
        <pt x=\"902\" y=\"442\" on=\"0\"/>
        <pt x=\"865\" y=\"463\" on=\"0\"/>
        <pt x=\"865\" y=\"491\" on=\"1\"/>
        <pt x=\"865\" y=\"516\" on=\"0\"/>
        <pt x=\"902\" y=\"543\" on=\"0\"/>
        <pt x=\"933\" y=\"543\" on=\"1\"/>
        <pt x=\"950\" y=\"543\" on=\"0\"/>
        <pt x=\"981\" y=\"536\" on=\"0\"/>
        <pt x=\"993\" y=\"531\" on=\"1\"/>
        <pt x=\"988\" y=\"521\" on=\"1\"/>
        <pt x=\"978\" y=\"527\" on=\"0\"/>
        <pt x=\"948\" y=\"533\" on=\"0\"/>
        <pt x=\"933\" y=\"533\" on=\"1\"/>
        <pt x=\"907\" y=\"533\" on=\"0\"/>
        <pt x=\"876\" y=\"512\" on=\"0\"/>
        <pt x=\"876\" y=\"491\" on=\"1\"/>
        <pt x=\"876\" y=\"467\" on=\"0\"/>
        <pt x=\"909\" y=\"451\" on=\"0\"/>
        <pt x=\"932\" y=\"443\" on=\"1\"/>
        <pt x=\"957\" y=\"435\" on=\"0\"/>
        <pt x=\"998\" y=\"413\" on=\"0\"/>
      </contour>
      <contour>
        <pt x=\"465\" y=\"539\" on=\"1\"/>
        <pt x=\"465\" y=\"330\" on=\"1\"/>
        <pt x=\"454\" y=\"330\" on=\"1\"/>
        <pt x=\"454\" y=\"539\" on=\"1\"/>
      </contour>
      <contour>
        <pt x=\"821\" y=\"539\" on=\"1\"/>
        <pt x=\"821\" y=\"330\" on=\"1\"/>
        <pt x=\"810\" y=\"330\" on=\"1\"/>
        <pt x=\"810\" y=\"539\" on=\"1\"/>
      </contour>
      <contour>
        <pt x=\"893\" y=\"12\" on=\"1\"/>
        <pt x=\"909\" y=\"12\" on=\"0\"/>
        <pt x=\"922\" y=\"17\" on=\"1\"/>
        <pt x=\"922\" y=\"7\" on=\"1\"/>
        <pt x=\"916\" y=\"5\" on=\"0\"/>
        <pt x=\"902\" y=\"2\" on=\"0\"/>
        <pt x=\"892\" y=\"2\" on=\"1\"/>
        <pt x=\"867\" y=\"2\" on=\"0\"/>
        <pt x=\"847\" y=\"33\" on=\"0\"/>
        <pt x=\"847\" y=\"61\" on=\"1\"/>
        <pt x=\"847\" y=\"205\" on=\"1\"/>
        <pt x=\"817\" y=\"205\" on=\"1\"/>
        <pt x=\"817\" y=\"214\" on=\"1\"/>
        <pt x=\"846\" y=\"215\" on=\"1\"/>
        <pt x=\"849\" y=\"267\" on=\"1\"/>
        <pt x=\"857\" y=\"267\" on=\"1\"/>
        <pt x=\"857\" y=\"215\" on=\"1\"/>
        <pt x=\"921\" y=\"215\" on=\"1\"/>
        <pt x=\"921\" y=\"205\" on=\"1\"/>
        <pt x=\"857\" y=\"205\" on=\"1\"/>
        <pt x=\"857\" y=\"62\" on=\"1\"/>
        <pt x=\"857\" y=\"38\" on=\"0\"/>
        <pt x=\"872\" y=\"12\" on=\"0\"/>
      </contour>
      <contour>
        <pt x=\"414\" y=\"12\" on=\"1\"/>
        <pt x=\"430\" y=\"12\" on=\"0\"/>
        <pt x=\"443\" y=\"17\" on=\"1\"/>
        <pt x=\"443\" y=\"7\" on=\"1\"/>
        <pt x=\"437\" y=\"5\" on=\"0\"/>
        <pt x=\"423\" y=\"2\" on=\"0\"/>
        <pt x=\"413\" y=\"2\" on=\"1\"/>
        <pt x=\"388\" y=\"2\" on=\"0\"/>
        <pt x=\"368\" y=\"33\" on=\"0\"/>
        <pt x=\"368\" y=\"61\" on=\"1\"/>
        <pt x=\"368\" y=\"205\" on=\"1\"/>
        <pt x=\"338\" y=\"205\" on=\"1\"/>
        <pt x=\"338\" y=\"214\" on=\"1\"/>
        <pt x=\"368\" y=\"215\" on=\"1\"/>
        <pt x=\"370\" y=\"267\" on=\"1\"/>
        <pt x=\"379\" y=\"267\" on=\"1\"/>
        <pt x=\"379\" y=\"215\" on=\"1\"/>
        <pt x=\"442\" y=\"215\" on=\"1\"/>
        <pt x=\"442\" y=\"205\" on=\"1\"/>
        <pt x=\"379\" y=\"205\" on=\"1\"/>
        <pt x=\"379\" y=\"62\" on=\"1\"/>
        <pt x=\"379\" y=\"38\" on=\"0\"/>
        <pt x=\"394\" y=\"12\" on=\"0\"/>
      </contour>
      <contour>
        <pt x=\"124\" y=\"226\" on=\"1\"/>
        <pt x=\"155\" y=\"226\" on=\"0\"/>
        <pt x=\"185\" y=\"191\" on=\"0\"/>
        <pt x=\"185\" y=\"152\" on=\"1\"/>
        <pt x=\"185\" y=\"14\" on=\"1\"/>
        <pt x=\"176\" y=\"14\" on=\"1\"/>
        <pt x=\"175\" y=\"54\" on=\"1\"/>
        <pt x=\"174\" y=\"54\" on=\"1\"/>
        <pt x=\"166\" y=\"36\" on=\"0\"/>
        <pt x=\"133\" y=\"10\" on=\"0\"/>
        <pt x=\"103\" y=\"10\" on=\"1\"/>
        <pt x=\"74\" y=\"10\" on=\"0\"/>
        <pt x=\"43\" y=\"40\" on=\"0\"/>
        <pt x=\"43\" y=\"65\" on=\"1\"/>
        <pt x=\"43\" y=\"96\" on=\"0\"/>
        <pt x=\"93\" y=\"127\" on=\"0\"/>
        <pt x=\"136\" y=\"130\" on=\"1\"/>
        <pt x=\"174\" y=\"132\" on=\"1\"/>
        <pt x=\"174\" y=\"149\" on=\"1\"/>
        <pt x=\"174\" y=\"185\" on=\"0\"/>
        <pt x=\"150\" y=\"216\" on=\"0\"/>
        <pt x=\"124\" y=\"216\" on=\"1\"/>
        <pt x=\"109\" y=\"216\" on=\"0\"/>
        <pt x=\"81\" y=\"209\" on=\"0\"/>
        <pt x=\"65\" y=\"200\" on=\"1\"/>
        <pt x=\"61\" y=\"211\" on=\"1\"/>
        <pt x=\"76\" y=\"218\" on=\"0\"/>
        <pt x=\"108\" y=\"226\" on=\"0\"/>
      </contour>
      <contour>
        <pt x=\"559\" y=\"215\" on=\"1\"/>
        <pt x=\"597\" y=\"215\" on=\"0\"/>
        <pt x=\"631\" y=\"158\" on=\"0\"/>
        <pt x=\"631\" y=\"117\" on=\"1\"/>
        <pt x=\"631\" y=\"107\" on=\"1\"/>
        <pt x=\"485\" y=\"107\" on=\"1\"/>
        <pt x=\"485\" y=\"8\" on=\"0\"/>
        <pt x=\"563\" y=\"8\" on=\"1\"/>
        <pt x=\"581\" y=\"8\" on=\"0\"/>
        <pt x=\"607\" y=\"13\" on=\"0\"/>
        <pt x=\"624\" y=\"22\" on=\"1\"/>
        <pt x=\"624\" y=\"11\" on=\"1\"/>
        <pt x=\"597\" y=\"-2\" on=\"0\"/>
        <pt x=\"563\" y=\"-2\" on=\"1\"/>
        <pt x=\"517\" y=\"-2\" on=\"0\"/>
        <pt x=\"474\" y=\"58\" on=\"0\"/>
        <pt x=\"474\" y=\"104\" on=\"1\"/>
        <pt x=\"474\" y=\"148\" on=\"0\"/>
        <pt x=\"516\" y=\"215\" on=\"0\"/>
      </contour>
      <contour>
        <pt x=\"800\" y=\"55\" on=\"1\"/>
        <pt x=\"800\" y=\"29\" on=\"0\"/>
        <pt x=\"763\" y=\"-2\" on=\"0\"/>
        <pt x=\"726\" y=\"-2\" on=\"1\"/>
        <pt x=\"706\" y=\"-2\" on=\"0\"/>
        <pt x=\"672\" y=\"7\" on=\"0\"/>
        <pt x=\"661\" y=\"11\" on=\"1\"/>
        <pt x=\"661\" y=\"23\" on=\"1\"/>
        <pt x=\"691\" y=\"8\" on=\"0\"/>
        <pt x=\"726\" y=\"8\" on=\"1\"/>
        <pt x=\"759\" y=\"8\" on=\"0\"/>
        <pt x=\"789\" y=\"33\" on=\"0\"/>
        <pt x=\"789\" y=\"55\" on=\"1\"/>
        <pt x=\"789\" y=\"78\" on=\"0\"/>
        <pt x=\"754\" y=\"98\" on=\"0\"/>
        <pt x=\"730\" y=\"105\" on=\"1\"/>
        <pt x=\"704\" y=\"114\" on=\"0\"/>
        <pt x=\"667\" y=\"134\" on=\"0\"/>
        <pt x=\"667\" y=\"163\" on=\"1\"/>
        <pt x=\"667\" y=\"187\" on=\"0\"/>
        <pt x=\"704\" y=\"215\" on=\"0\"/>
        <pt x=\"735\" y=\"215\" on=\"1\"/>
        <pt x=\"753\" y=\"215\" on=\"0\"/>
        <pt x=\"783\" y=\"208\" on=\"0\"/>
        <pt x=\"795\" y=\"203\" on=\"1\"/>
        <pt x=\"791\" y=\"193\" on=\"1\"/>
        <pt x=\"767\" y=\"205\" on=\"0\"/>
        <pt x=\"735\" y=\"205\" on=\"1\"/>
        <pt x=\"709\" y=\"205\" on=\"0\"/>
        <pt x=\"678\" y=\"184\" on=\"0\"/>
        <pt x=\"678\" y=\"163\" on=\"1\"/>
        <pt x=\"678\" y=\"138\" on=\"0\"/>
        <pt x=\"711\" y=\"123\" on=\"0\"/>
        <pt x=\"734\" y=\"115\" on=\"1\"/>
        <pt x=\"759\" y=\"107\" on=\"0\"/>
        <pt x=\"800\" y=\"85\" on=\"0\"/>
      </contour>
      <contour>
        <pt x=\"559\" y=\"205\" on=\"1\"/>
        <pt x=\"528\" y=\"205\" on=\"0\"/>
        <pt x=\"489\" y=\"160\" on=\"0\"/>
        <pt x=\"486\" y=\"117\" on=\"1\"/>
        <pt x=\"620\" y=\"117\" on=\"1\"/>
        <pt x=\"620\" y=\"156\" on=\"0\"/>
        <pt x=\"591\" y=\"205\" on=\"0\"/>
      </contour>
      <contour>
        <pt x=\"138\" y=\"121\" on=\"1\"/>
        <pt x=\"100\" y=\"119\" on=\"0\"/>
        <pt x=\"54\" y=\"93\" on=\"0\"/>
        <pt x=\"54\" y=\"65\" on=\"1\"/>
        <pt x=\"54\" y=\"20\" on=\"0\"/>
        <pt x=\"103\" y=\"20\" on=\"1\"/>
        <pt x=\"140\" y=\"20\" on=\"0\"/>
        <pt x=\"174\" y=\"65\" on=\"0\"/>
        <pt x=\"174\" y=\"101\" on=\"1\"/>
        <pt x=\"174\" y=\"122\" on=\"1\"/>
      </contour>
      <instructions/>
    </TTGlyph>

    <TTGlyph name=\"uni0E71\" xMin=\"68\" yMin=\"84\" xMax=\"498\" yMax=\"514\">
      <contour>
        <pt x=\"283\" y=\"84\" on=\"1\"/>
        <pt x=\"224\" y=\"84\" on=\"0\"/>
        <pt x=\"126\" y=\"142\" on=\"0\"/>
        <pt x=\"68\" y=\"239\" on=\"0\"/>
        <pt x=\"68\" y=\"299\" on=\"1\"/>
        <pt x=\"68\" y=\"359\" on=\"0\"/>
        <pt x=\"126\" y=\"456\" on=\"0\"/>
        <pt x=\"224\" y=\"514\" on=\"0\"/>
        <pt x=\"283\" y=\"514\" on=\"1\"/>
        <pt x=\"343\" y=\"514\" on=\"0\"/>
        <pt x=\"440\" y=\"456\" on=\"0\"/>
        <pt x=\"498\" y=\"359\" on=\"0\"/>
        <pt x=\"498\" y=\"299\" on=\"1\"/>
        <pt x=\"498\" y=\"239\" on=\"0\"/>
        <pt x=\"440\" y=\"142\" on=\"0\"/>
        <pt x=\"343\" y=\"84\" on=\"0\"/>
      </contour>
      <instructions/>
    </TTGlyph>

  </glyf>


  <hhea>
    <tableVersion value=\"0x00010000\"/>
    <ascent value=\"1000\"/>
    <descent value=\"-200\"/>
    <lineGap value=\"0\"/>
    <advanceWidthMax value=\"1024\"/>
    <minLeftSideBearing value=\"26\"/>
    <minRightSideBearing value=\"26\"/>
    <xMaxExtent value=\"998\"/>
    <caretSlopeRise value=\"1000\"/>
    <caretSlopeRun value=\"0\"/>
    <caretOffset value=\"0\"/>
    <reserved0 value=\"0\"/>
    <reserved1 value=\"0\"/>
    <reserved2 value=\"0\"/>
    <reserved3 value=\"0\"/>
    <metricDataFormat value=\"0\"/>
    <numberOfHMetrics value=\"4\"/>
  </hhea>


  <hmtx>
    <mtx name=\".notdef\" width=\"500\" lsb=\"50\"/>
    <mtx name=\"space\" width=\"200\" lsb=\"0\"/>
    <mtx name=\"uni0E70\" width=\"1024\" lsb=\"26\"/>
    <mtx name=\"uni0E71\" width=\"566\" lsb=\"68\"/>
  </hmtx>


  <loca>
    <!-- The 'loca' table will be calculated by the compiler -->
  </loca>


  <maxp>
    <!-- Most of this table will be recalculated by the compiler -->
    <tableVersion value=\"0x10000\"/>
    <numGlyphs value=\"4\"/>
    <maxPoints value=\"278\"/>
    <maxContours value=\"15\"/>
    <maxCompositePoints value=\"0\"/>
    <maxCompositeContours value=\"0\"/>
    <maxZones value=\"1\"/>
    <maxTwilightPoints value=\"0\"/>
    <maxStorage value=\"0\"/>
    <maxFunctionDefs value=\"0\"/>
    <maxInstructionDefs value=\"0\"/>
    <maxStackElements value=\"0\"/>
    <maxSizeOfInstructions value=\"0\"/>
    <maxComponentElements value=\"0\"/>
    <maxComponentDepth value=\"0\"/>
  </maxp>


  <post>
    <formatType value=\"2.0\"/>
    <italicAngle value=\"0.0\"/>
    <underlinePosition value=\"-100\"/>
    <underlineThickness value=\"50\"/>
    <isFixedPitch value=\"0\"/>
    <minMemType42 value=\"0\"/>
    <maxMemType42 value=\"0\"/>
    <minMemType1 value=\"0\"/>
    <maxMemType1 value=\"0\"/>
    <psNames>
      <!-- This file uses unique glyph names based on the information
           found in the 'post' table. Since these names might not be unique,
           we have to invent artificial names in case of clashes. In order to
           be able to retain the original information, we need a name to
           ps name mapping for those cases where they differ. That's what
           you see below.
            -->
    </psNames>
    <extraNames>
      <!-- following are the name that are not taken from the standard Mac glyph order -->
      <psName name=\"uni0E70\"/>
      <psName name=\"uni0E71\"/>
    </extraNames>
  </post>
</ttFont>
"))))

(ert-deftest ttx-mode-opens-ttf ()
  "Opening a ttf font shows table metadata."
  (let ((ttx-default-tables '("cmap")))
    (ttx-test-with-font ttx-test-font-ttf
      (should (equal (buffer-string)
                     "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<ttFont>
  <!-- Available tables (use ttx-load-table to load): -->
  <!-- OS/2 (96B) -->
  <!-- cmap (60B) -->
  <!-- glyf (832B) -->
  <!-- head (54B) -->
  <!-- hhea (36B) -->
  <!-- hmtx (16B) -->
  <!-- loca (10B) -->
  <!-- maxp (32B) -->
  <!-- name (1.2KiB) -->
  <!-- post (58B) -->


  <cmap>
    <tableVersion version=\"0\"/>
    <cmap_format_4 platformID=\"0\" platEncID=\"3\" language=\"0\">
      <map code=\"0x20\" name=\"space\"/><!-- SPACE -->
      <map code=\"0xe70\" name=\"uni0E70\"/><!-- ???? -->
      <map code=\"0xe71\" name=\"uni0E71\"/><!-- ???? -->
    </cmap_format_4>
    <cmap_format_4 platformID=\"3\" platEncID=\"1\" language=\"0\">
      <map code=\"0x20\" name=\"space\"/><!-- SPACE -->
      <map code=\"0xe70\" name=\"uni0E70\"/><!-- ???? -->
      <map code=\"0xe71\" name=\"uni0E71\"/><!-- ???? -->
    </cmap_format_4>
  </cmap>
</ttFont>
")))))

(ert-deftest ttx-mode-opens-woff2 ()
  "Opening a woff2 font produces equivalent content to the original ttf."
  (let ((ttx-default-tables '("cmap")))
    ;; We would prefer to test that the woff2 buffer is equivalent to the ttf
    ;; buffer, but the encoding subtly changes some of the contents.
    (ttx-test-with-font ttx-test-font-woff2
      (should (equal (buffer-string)
                     "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<ttFont>
  <!-- Available tables (use ttx-load-table to load): -->
  <!-- OS/2 (96B) -->
  <!-- cmap (60B) -->
  <!-- glyf (836B) -->
  <!-- head (54B) -->
  <!-- hhea (36B) -->
  <!-- hmtx (16B) -->
  <!-- loca (10B) -->
  <!-- maxp (32B) -->
  <!-- name (1.2KiB) -->
  <!-- post (58B) -->


  <cmap>
    <tableVersion version=\"0\"/>
    <cmap_format_4 platformID=\"0\" platEncID=\"3\" language=\"0\">
      <map code=\"0x20\" name=\"space\"/><!-- SPACE -->
      <map code=\"0xe70\" name=\"uni0E70\"/><!-- ???? -->
      <map code=\"0xe71\" name=\"uni0E71\"/><!-- ???? -->
    </cmap_format_4>
    <cmap_format_4 platformID=\"3\" platEncID=\"1\" language=\"0\">
      <map code=\"0x20\" name=\"space\"/><!-- SPACE -->
      <map code=\"0xe70\" name=\"uni0E70\"/><!-- ???? -->
      <map code=\"0xe71\" name=\"uni0E71\"/><!-- ???? -->
    </cmap_format_4>
  </cmap>
</ttFont>
")))))

(ert-deftest ttx-parse-table-list ()
  "Parse ttx -l output into an alist."
  (should (equal (ttx--parse-table-list
                  "    head                  0x000  54\n    name                  0x000  1234\n")
                 '(("head" . 54) ("name" . 1234)))))

(ert-deftest ttx-generate-skeleton ()
  "Generate XML skeleton from a table alist."
  (should (equal (ttx--generate-skeleton '(("head" . 54) ("name" . 1234)))
                 "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<ttFont>
  <!-- Available tables (use ttx-load-table to load): -->
  <!-- head (54B) -->
  <!-- name (1.2KiB) -->
</ttFont>
")))

(ert-deftest ttx-extract-table-xml ()
  "Extract a single table block from full XML output."
  (let ((xml "<?xml?>\n<ttFont>\n  <head>\n    <foo/>\n  </head>\n</ttFont>\n"))
    (should (equal (ttx--extract-table-xml xml "head")
                   "  <head>\n    <foo/>\n  </head>"))))

(ert-deftest ttx-mode-buffer-is-read-only ()
  "Buffer must be read-only after ttx-mode activates."
  (let ((ttx-default-tables nil))
    (ttx-test-with-font ttx-test-font-ttf
      (should buffer-read-only))))

(ert-deftest ttx-mode-buffer-not-modified-after-open ()
  "Buffer must not be marked modified after initial load."
  (let ((ttx-default-tables nil))
    (ttx-test-with-font ttx-test-font-ttf
      (should-not (buffer-modified-p)))))

(ert-deftest ttx-available-tables-excludes-loaded ()
  "Available-to-load list omits tables already loaded."
  (let ((ttx-default-tables '("head")))
    (ttx-test-with-font ttx-test-font-ttf
      (should-not (assoc "head" (ttx--available-tables-to-load))))))

(ert-deftest ttx-load-single-table ()
  "Load one table and verify it appears in the buffer."
  (let ((ttx-default-tables nil))
    (ttx-test-with-font ttx-test-font-ttf
      (ttx-load-tables '("head"))
      (should (member "head" ttx--loaded-tables))
      (should (equal (buffer-string) ttx-test-font-ttf-as-ttx-with-head)))))

(ert-deftest ttx-mode-buffer-not-modified-after-load ()
  "Buffer must not be marked modified after loading a table."
  (let ((ttx-default-tables nil))
    (ttx-test-with-font ttx-test-font-ttf
      (ttx-load-tables '("head"))
      (should-not (buffer-modified-p)))))

(ert-deftest ttx-default-tables-skips-unavailable ()
  "Tags in ttx-default-tables that the font lacks are ignored."
  (let ((ttx-default-tables '("nonexistent-tag")))
    (ttx-test-with-font ttx-test-font-ttf
      (should (null ttx--loaded-tables)))))

(ert-deftest ttx-unload-table ()
  "Unloading a table removes it from the buffer and loaded list."
  (let ((ttx-default-tables '("head")))
    (ttx-test-with-font ttx-test-font-ttf
      (ttx-unload-table "head")
      (should-not (member "head" ttx--loaded-tables))
      (should (equal (buffer-string) ttx-test-font-ttf-as-ttx)))))

(ert-deftest ttx-mode-buffer-not-modified-after-unload ()
  "Buffer must not be marked modified after unloading a table."
  (let ((ttx-default-tables '("head")))
    (ttx-test-with-font ttx-test-font-ttf
      (ttx-unload-table "head")
      (should-not (buffer-modified-p)))))

(ert-deftest ttx-unload-table-slash-tag ()
  "Unloading a table whose tag contains '/' (e.g. OS/2) works correctly."
  (let ((ttx-default-tables '("OS/2")))
    (ttx-test-with-font ttx-test-font-ttf
      (should (member "OS/2" ttx--loaded-tables))
      (ttx-unload-table "OS/2")
      (should-not (member "OS/2" ttx--loaded-tables))
      (should (equal (buffer-string) ttx-test-font-ttf-as-ttx)))))

(ert-deftest ttx-revert-buffer ()
  "Reverting the buffer resets it to the default table state."
  (let ((ttx-default-tables '("head")))
    (ttx-test-with-font ttx-test-font-ttf
      (ttx-load-tables '("name"))
      (ttx-revert-buffer nil nil)
      (should (equal ttx--loaded-tables '("head")))
      (should (equal (buffer-string) ttx-test-font-ttf-as-ttx-with-head)))))

(ert-deftest ttx-missing-command-signals-error ()
  "ttx--run-command signals a user-error when ttx-command is not found."
  (let ((ttx-command "/usr/bin/does-not-exist"))
    (should-error
     (ttx--run-command "-l" ttx-test-font-ttf)
     :type 'user-error)))

(ert-deftest ttx-missing-woff2-command-signals-error ()
  "ttx--decompress-woff2 signals a user-error when woff2_decompress is not found."
  (let ((ttx-woff2-decompress-command "/usr/bin/does-not-exist"))
    (should-error
     (ttx--decompress-woff2 ttx-test-font-woff2)
     :type 'user-error)))

(ert-deftest ttx-mode-failed-init-leaves-recoverable-buffer ()
  "After a failed mode activation the buffer must remain recoverable.
The buffer must stay editable and the mode must be re-entrant so the
user can retry after fixing the cause."
  (let ((ttx-woff2-decompress-command "/usr/bin/does-not-exist")
        (ttx-default-tables nil))
    (with-temp-buffer
      (setq buffer-file-name ttx-test-font-woff2)
      ;; Activation signals a user-error mid-init.
      (let ((err (should-error (ttx-mode) :type 'user-error)))
        (should (string-match-p "woff2" (error-message-string err))))
      ;; Init never finished: the buffer stays writable...
      (should-not buffer-read-only)
      (with-demoted-errors "insert: %S"
        (insert "editable"))
      ;; ...and ttx-font-filename is unset, so a retry actually re-runs.
      (should-not ttx-font-filename)
      ;; Retrying the mode must not silently no-op.
      (should-error (ttx-mode) :type 'user-error))))

(provide 'ttx-mode-tests)
;;; ttx-mode-tests.el ends here
