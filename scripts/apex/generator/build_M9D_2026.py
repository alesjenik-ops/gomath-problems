# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9D 2026 (2. náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9D_2026_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2026, 2. náhradní termín (M9D)"
CCODE = "M9PDD26C0T04"
YR = 2026
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2026 M9D · úloha 1", pts=1, mins=2, diff="3",
    zad=[r"Filip se učil házet oštěpem. Délka jeho prvního hodu byla $7\ \mathrm{m}$. Každý další hod byl o desetinu delší než předchozí hod.",
         r"Vypočtěte, o kolik cm byl Filipův třetí hod delší než první."],
    solp=[r"Druhý hod: $7\cdot1{,}1=7{,}7\ \mathrm{m}$; třetí hod: $7{,}7\cdot1{,}1=8{,}47\ \mathrm{m}$.",
          r"Rozdíl: $8{,}47-7=1{,}47\ \mathrm{m}=147\ \mathrm{cm}$."],
    ans=r"o $147\ \mathrm{cm}$",
    codes=["zs2", "r9", "aritmetika", "desetinna-cisla", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 2", pts=4, mins=5, diff="3",
    zad=[r"Vypočtěte:",
         r"2.1 \quad $0{,}5\cdot(-0{,}04)-100\cdot0{,}02=$",
         r"2.2 \quad $\left(\dfrac{18}{14}\cdot\dfrac{7}{6}-1\right):6=$ (výsledek zlomkem v základním tvaru)",
         r"2.3 \quad $\left(\dfrac{7}{2}-\dfrac{1}{6}\right):\left(12-6\cdot\dfrac{3}{4}\right)=$ (výsledek zlomkem v základním tvaru)"],
    solp=[r"2.1: $-0{,}02-2=-2{,}02$.",
          r"2.2: $\frac{18}{14}\cdot\frac{7}{6}=\frac{3}{2}$; $\left(\frac{3}{2}-1\right):6=\frac{1}{2}:6=\frac{1}{12}$.",
          r"2.3: $\frac{7}{2}-\frac{1}{6}=\frac{10}{3}$; $12-\frac{18}{4}=\frac{15}{2}$; $\frac{10}{3}:\frac{15}{2}=\frac{4}{9}$."],
    ans=r"2.1: $-2{,}02$; 2.2: $\frac{1}{12}$; 2.3: $\frac{4}{9}$",
    codes=["zs2", "r9", "zlomky", "desetinna-cisla", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"3.1 Vytkněte $(-x)$: $-4x^2-x+8xy=$",
         r"3.2 Roznásobte a upravte (výsledný výraz nesmí obsahovat závorky): $\dfrac{1}{2}\cdot(2a+4)^2=$",
         r"3.3 Upravte na co nejjednodušší tvar bez závorek: $(2+2n)\cdot(2-2n)-2\cdot(n+1)+(4n-n)\cdot3n=$"],
    solp=[r"3.1: $-4x^2-x+8xy=(-x)\cdot(4x-8y+1)$.",
          r"3.2: $\frac{1}{2}(4a^2+16a+16)=2a^2+8a+8$.",
          r"3.3: $(4-4n^2)-(2n+2)+9n^2=5n^2-2n+2$."],
    ans=r"3.1: $(-x)(4x-8y+1)$; 3.2: $2a^2+8a+8$; 3.3: $5n^2-2n+2$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnici:",
         r"4.1 \quad $0{,}5\cdot(3-5x)=0{,}25\cdot(3x+6)$",
         r"4.2 \quad $\dfrac{5}{3}\cdot\left(y-\dfrac{3}{2}\right)+\dfrac{1}{2}\cdot y=\dfrac{5}{9}\cdot(3y-9)$"],
    solp=[r"4.1: $1{,}5-2{,}5x=0{,}75x+1{,}5\Rightarrow -2{,}5x=0{,}75x\Rightarrow -3{,}25x=0\Rightarrow x=0$.",
          r"4.2: $\frac{5}{3}y-\frac{5}{2}+\frac{1}{2}y=\frac{5}{3}y-5\Rightarrow -\frac{5}{2}+\frac{1}{2}y=-5\Rightarrow \frac{1}{2}y=-\frac{5}{2}\Rightarrow y=-5$."],
    ans=r"4.1: $x=0$; 4.2: $y=-5$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Na výstavbě kanalizace se podílejí tři firmy: Roura, Trubka a Potrubí. Úsek firmy Roura je dvakrát delší než úsek firmy Trubka. Úsek firmy Potrubí má čtyřikrát menší délku, než mají dohromady úseky obou zbývajících firem. Délku úseku firmy Roura označíme $r$.",
         r"5.1 Vyjádřete výrazem s proměnnou $r$ délku úseku firmy Trubka.",
         r"5.2 Vyjádřete výrazem s proměnnou $r$ délku úseku firmy Potrubí.",
         r"5.3 Firma Potrubí staví úsek o $12\ \mathrm{km}$ kratší než firma Trubka. Vypočtěte v km délku úseku firmy Roura."],
    solp=[r"5.1: Trubka $=\frac{r}{2}$.",
          r"5.2: Potrubí $=\frac{1}{4}\left(r+\frac{r}{2}\right)=\frac{3}{8}r$.",
          r"5.3: $\frac{r}{2}-\frac{3}{8}r=\frac{r}{8}=12\Rightarrow r=96\ \mathrm{km}$."],
    ans=r"5.1: $\frac{r}{2}$; 5.2: $\frac{3}{8}r$; 5.3: $96\ \mathrm{km}$",
    codes=["zs2", "r9", "vyrazy", "rovnice", "algebra", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 6", pts=2, mins=4, diff="3",
    zad=[r"Obdélník $ABCD$ je složen z bílého a šedého obdélníku jako na obrázku. Obvod obdélníku $ABCD$ je $68\ \mathrm{cm}$ a délka strany $BC$ je $10\ \mathrm{cm}$. Obvod šedého obdélníku je o $12\ \mathrm{cm}$ větší než obvod bílého obdélníku.",
         r"6.1 Vypočtěte v cm délku strany $AB$ obdélníku $ABCD$.",
         r"6.2 Vypočtěte v $\mathrm{cm}^2$ obsah šedého obdélníku."],
    solp=[r"6.1: $2(AB+10)=68\Rightarrow AB=24\ \mathrm{cm}$.",
          r"6.2: šířky bílého $w$ a šedého $24-w$ (výška $10$). Rozdíl obvodů $2\big((24-w)-w\big)=12\Rightarrow w=9$; šedý má šířku $15$, obsah $15\cdot10=150\ \mathrm{cm}^2$."],
    ans=r"6.1: $24\ \mathrm{cm}$; 6.2: $150\ \mathrm{cm}^2$",
    svg=fig(3, (332, 470, 595, 602)), fn=FN,
    alt="Obdélník ABCD složený z bílého a šedého obdélníku.", cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 7", pts=3, mins=5, diff="4",
    zad=[r"Na bílé krychli $ABCDEFGH$ jsme vyznačili středy $M$, $N$ hran $AB$ a $FG$. Na třech stěnách krychle jsme zakreslili šedé pravoúhlé lichoběžníky $MBFE$, $BCNF$ a $HEFN$ (viz obrázek). Ostatní stěny zůstaly bílé.",
         r"7.1 Zapište zlomkem v základním tvaru, jakou část plochy přední stěny tvoří šedý lichoběžník $MBFE$.",
         r"7.2 Určete poměr obsahu šedé plochy ku obsahu bílé plochy na povrchu celé krychle (v základním tvaru)."],
    solp=[r"Nechť hrana krychle je $a$. Lichoběžník $MBFE$ má rovnoběžné strany $MB=\frac{a}{2}$ a $EF=a$, výšku $a$; jeho obsah je $\frac{1}{2}\left(\frac{a}{2}+a\right)a=\frac{3}{4}a^2$.",
          r"7.1: podíl na přední stěně je $\frac{3}{4}$.",
          r"7.2: součet obsahů tří shodných lichoběžníků je $\frac{9}{4}a^2$; povrch krychle je $6a^2$, bílá plocha $\frac{15}{4}a^2$; poměr $\frac{9}{4}:\frac{15}{4}=3:5$."],
    ans=r"7.1: $\frac{3}{4}$; 7.2: $3:5$",
    svg=fig(4, (335, 60, 595, 246)), fn=FN,
    alt="Krychle ABCDEFGH se středy M, N hran AB a FG a se třemi šedými pravoúhlými lichoběžníky MBFE, BCNF, HEFN.",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 8", pts=3, mins=5, diff="3",
    zad=[r"V parku běží dva běžci trasu dlouhou $8\ \mathrm{km}$; žádný z nich nemění rychlost. Rychlejší běžec uběhne celou trasu za $40$ minut. Rychlejší běžec uběhne $3\ \mathrm{km}$ za čas, za který pomalejší běžec uběhne $2\,500\ \mathrm{m}$.",
         r"8.1 Vypočtěte v minutách, za jaký čas uběhne rychlejší běžec $3\ \mathrm{km}$.",
         r"8.2 Vypočtěte v minutách, za jaký čas uběhne pomalejší běžec celou trasu."],
    solp=[r"8.1: rychlejší $8\ \mathrm{km}$ za $40$ min, tedy $3\ \mathrm{km}$ za $40\cdot\frac{3}{8}=15$ minut.",
          r"8.2: za $15$ minut uběhne pomalejší $2\,500\ \mathrm{m}$; celou trasu $8\,000\ \mathrm{m}$ uběhne za $15\cdot\frac{8\,000}{2\,500}=48$ minut."],
    ans=r"8.1: $15$ minut; 8.2: $48$ minut",
    codes=["zs2", "r9", "aritmetika", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží přímka $p$ a body $B$, $D$ (viz obrázek).",
         r"Body $B$, $D$ jsou vrcholy pravoúhlého rovnoramenného trojúhelníku $BCD$ s pravým úhlem při vrcholu $C$. Bod $C$ má od přímky $p$ větší vzdálenost než bod $B$.",
         r"9.1 Sestrojte vrchol $C$ trojúhelníku $BCD$ a označte ho písmenem.",
         r"9.2 Body $B$, $C$, $D$ jsou zároveň vrcholy lichoběžníku $ABCD$; vrchol $A$ leží na přímce $p$. Sestrojte vrchol $A$, označte ho a lichoběžník narýsujte. Najděte všechna řešení."],
    solp=[r"9.1: pravý úhel u $C$ znamená, že $C$ leží na Thaletově kružnici nad $BD$; rovnoramennost ($CB=CD$) dává $C$ na ose úsečky $BD$. Průsečík dál od $p$ je hledaný vrchol $C$.",
          r"9.2: vrchol $A$ leží na přímce $p$ tak, aby $ABCD$ byl lichoběžník (např. $AB\parallel DC$); úloha má více řešení."],
    ans=r"Vrchol $C$ je průsečík Thaletovy kružnice nad $BD$ a osy $BD$ (dál od $p$); vrchol $A$ leží na $p$ tak, aby $ABCD$ byl lichoběžník (více řešení).",
    svg=fig(5, (66, 90, 595, 360)), fn=FN,
    alt="Přímka p a body B, D v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 10", pts=2, mins=5, diff="4",
    zad=[r"V rovině leží body $D$, $S$, $U$ (viz obrázek).",
         r"Bod $D$ je vrchol obdélníku $ABCD$. Bod $S$ je střed kružnice $k$, na níž leží všechny vrcholy tohoto obdélníku. Bodem $U$ prochází přímka $u$, na které leží vrcholy $A$, $C$ obdélníku $ABCD$.",
         r"Sestrojte kružnici $k$ a vrcholy $A$, $B$, $C$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte."],
    solp=[r"Kružnice $k$ má střed $S$ a poloměr $|SD|$ (opsaná kružnice obdélníku).",
          r"Úhlopříčka $AC$ prochází středem $S$, proto přímka $u=SU$; vrcholy $A$, $C$ jsou průsečíky přímky $u$ s kružnicí $k$.",
          r"Vrchol $B$ je obraz $D$ ve středové souměrnosti podle $S$."],
    ans=r"Kružnice $k(S,|SD|)$; $A$, $C$ jsou průsečíky přímky $SU$ s $k$; vrchol $B$ je obraz $D$ podle středu $S$.",
    svg=fig(6, (66, 64, 595, 380)), fn=FN,
    alt="Body D, S, U v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 11", pts=4, mins=5, diff="4",
    zad=[r"Pavle je $17$ let. Od $12$ let si vždy v den narozenin zapisuje svou výšku v celých cm. V grafu jsou zaznamenány tři z těchto výšek, zbývající tři chybí. Během tří let od $12.$ do $15.$ narozenin povyrostla Pavla každým rokem o stejný počet cm. Pavlina výška v den $16.$ narozenin je aritmetickým průměrem výšek zapsaných ve dnech $15.$ a $17.$ narozenin.",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), nebo nepravdivé (N):",
         r"11.1 Od $15.$ do $17.$ narozenin vyrostla Pavla celkem o $5\ \mathrm{cm}$.",
         r"11.2 V den $14.$ narozenin měřila Pavla $167\ \mathrm{cm}$.",
         r"11.3 Aritmetický průměr všech šesti zapsaných výšek je $167\ \mathrm{cm}$."],
    solp=[r"Z grafu: výška ve $13$ letech $163\ \mathrm{cm}$, v $16$ letech $171\ \mathrm{cm}$, v $17$ letech $173\ \mathrm{cm}$. Od $12$ do $15$ přírůstek stejný, výška v $16$ je průměr výšek v $15$ a $17$.",
          r"Dopočtené výšky: $12\!:\!161$, $14\!:\!165$, $15\!:\!167$ cm.",
          r"11.1: $173-167=6\ \mathrm{cm}$, nikoli $5$ — N. 11.2: v $14$ letech $165\ \mathrm{cm}$, nikoli $167$ — N. 11.3: průměr $\frac{161+163+165+167+171+173}{6}=167\ \mathrm{cm}$ — A."],
    ans=r"11.1: N; 11.2: N; 11.3: A",
    svg=fig(7, (78, 176, 405, 322)), fn=FN,
    alt="Sloupcový graf výšky Pavly v cm ve dnech 12. až 17. narozenin; tři údaje (12, 14, 15 let) chybí.",
    cap="",
    codes=["zs2", "r9", "statistika", "posloupnosti", "porozumeni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 12", pts=2, mins=4, diff="3",
    zad=[r"Květa si koupila čtyřdílný román. První díl byl o $30\ \%$ levnější než druhý díl, třetí díl o $30\ \%$ dražší než druhý díl. Čtvrtý díl stojí běžně $680$ korun, ale Květa ho koupila v akci za $40\ \%$ běžné ceny a zaplatila za něj stejně jako za první a třetí díl dohromady.",
         r"Kolik korun stál druhý díl románu?"],
    opts=[r"A) $172$ korun", r"B) $170$ korun", r"C) $160$ korun", r"D) $142$ korun", r"E) $136$ korun"],
    solp=[r"Čtvrtý díl v akci: $0{,}4\cdot680=272$ korun.",
          r"První $+$ třetí díl: $0{,}7d_2+1{,}3d_2=2d_2=272\Rightarrow d_2=136$ korun."],
    ans=r"E) $136$ korun",
    codes=["zs2", "r9", "procenta", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 13", pts=2, mins=4, diff="3",
    zad=[r"Děti se měly rozdělit do stejně početných skupin. Při dělení do trojic jedno dítě zbylo, při dělení do pětic nikdo nezbyl. Počet vytvořených pětic byl o $9$ menší než počet trojic.",
         r"Kolik pětic děti vytvořily?"],
    opts=[r"A) $11$ pětic", r"B) $12$ pětic", r"C) $13$ pětic", r"D) $14$ pětic", r"E) jiný počet pětic"],
    solp=[r"Nechť je $p$ pětic, dětí je $5p$. Trojic je $\frac{5p-1}{3}$ a platí $\frac{5p-1}{3}=p+9$.",
          r"$5p-1=3p+27\Rightarrow 2p=28\Rightarrow p=14$ (dětí $70$; $70=3\cdot23+1$)."],
    ans=r"D) $14$ pětic",
    codes=["zs2", "r9", "rovnice", "aritmetika", "slovni", "modelovani", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 14", pts=2, mins=4, diff="4",
    zad=[r"Na obrázku je síť hranolu, který má podstavy tvaru kosočtverce a boční stěny tvaru čtverce. Obsah jedné podstavy je $15\ \mathrm{cm}^2$. Součet délek všech hran hranolu je $60\ \mathrm{cm}$.",
         r"Jaký je objem hranolu?"],
    opts=[r"A) $60\ \mathrm{cm}^3$", r"B) $75\ \mathrm{cm}^3$", r"C) $90\ \mathrm{cm}^3$", r"D) $105\ \mathrm{cm}^3$", r"E) jiný objem"],
    solp=[r"Boční stěny jsou čtverce, proto výška hranolu $=$ straně kosočtverce $a$. Hranol má $8$ hran podstav a $4$ boční hrany, všechny délky $a$: $12a=60\Rightarrow a=5\ \mathrm{cm}$.",
          r"Objem $=$ obsah podstavy $\times$ výška $=15\cdot5=75\ \mathrm{cm}^3$."],
    ans=r"B) $75\ \mathrm{cm}^3$",
    svg=fig(8, (405, 350, 595, 472)), fn=FN,
    alt="Síť hranolu s podstavami tvaru kosočtverce a bočními stěnami tvaru čtverce.",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 15", pts=6, mins=6, diff="3",
    zad=[r"Tabulka udává počty žáků gymnázia, kteří se zúčastnili sportovních kurzů (některé údaje chybí): Vodácký kurz — celkem $28$; Turistický kurz — celkem $30$; Cyklistický kurz — chlapci $14$.",
         r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Z celkového počtu účastníků vodáckého kurzu bylo $75\ \%$ chlapců. Kolik dívek se zúčastnilo vodáckého kurzu?",
         r"15.2 Turistického kurzu se zúčastnilo o $50\ \%$ více dívek než chlapců. O kolik méně chlapců než dívek se zúčastnilo turistického kurzu?",
         r"15.3 Na cyklistický kurz se přihlásilo $16$ dívek, některé se nezúčastnily; dívky nakonec tvořily $44\ \%$ účastníků. Kolik přihlášených dívek se kurzu nezúčastnilo?"],
    opts=[r"A) $5$", r"B) $6$", r"C) $7$", r"D) $8$", r"E) $9$", r"F) jiný počet"],
    solp=[r"15.1: dívky $=25\ \%$ z $28=7$ — C.",
          r"15.2: chlapci $c$, dívky $1{,}5c$; $2{,}5c=30\Rightarrow c=12$, dívek $18$; rozdíl $6$ — B.",
          r"15.3: chlapci $14=56\ \%$ účastníků, celkem $25$, dívek $11$; přihlášeno $16$, nezúčastnilo se $5$ — A."],
    ans=r"15.1: C ($7$); 15.2: B ($6$); 15.3: A ($5$)",
    svg=fig(9, (66, 110, 300, 225)), fn=FN,
    alt="Tabulka počtu účastníků kurzů (chlapci, dívky, celkem) pro vodácký, turistický a cyklistický kurz s chybějícími údaji.",
    cap="",
    codes=["zs2", "r9", "procenta", "statistika", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9D · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Vědomostní hra má $10$ kol. Hráč má na začátku $10$ žetonů a může odpovědět na $5$ lehčích a $5$ těžších otázek. V každém kole si může koupit pouze $1$ otázku za $1$ žeton; pokud kolo vynechá, žeton mu zůstane. Za správnou odpověď na lehčí otázku získá $2$ žetony, na těžší $3$ žetony, za chybnou odpověď nic.",
         r"16.1 Určete, kolik nejvíce žetonů může mít hráč na konci hry.",
         r"16.2 Hráč vynechal pouze $1$ kolo a ve zbývajících kolech získal za lehčí otázky o $3$ žetony více než za těžší. Určete, kolik žetonů měl na konci hry.",
         r"16.3 Hráč měl na konci hry $10$ žetonů a přitom měl největší možný počet chybných odpovědí. Určete, kolikrát správně odpověděl na lehčí otázku. Uveďte všechna řešení."],
    solp=[r"Čistý zisk za správnou lehčí otázku je $+1$ žeton, za správnou těžší $+2$ žetony.",
          r"16.1: všech $10$ správně: $10+5\cdot1+5\cdot2=25$ žetonů.",
          r"16.2: koupil $9$ otázek; $2L=3T+3$ a konečný počet $10-9+2L+3T=1+2L+3T$. Z $2L=3T+3$ a řešení vychází $L=3$, $T=1$, konec $=10$ žetonů.",
          r"16.3: konec $10$ žetonů znamená $L+2T=9$; největší počet chyb $\Rightarrow$ nejméně správných; řešení jsou $L=0,\,T=... $ dle rozboru: hráč odpověděl správně na lehčí otázku buď ani jednou, nebo dvakrát."],
    ans=r"16.1: $25$ žetonů; 16.2: $10$ žetonů; 16.3: ani jednou nebo dvakrát",
    codes=["zs2", "r9", "aritmetika", "argumentace", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9D-2026")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
