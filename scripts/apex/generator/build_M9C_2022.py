# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9C 2022 (náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9C_2022_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2022, náhradní termín (M9C)"
CCODE = "M9PCD22C0T03"
YR = 2022
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2022 M9C · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte:",
         r"$\dfrac{10^2\cdot(10^2-1)}{10\cdot10^2+10^2}=$"],
    solp=[r"$\dfrac{100\cdot99}{1000+100}=\dfrac{9900}{1100}=9$."],
    ans=r"$9$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 2", pts=2, mins=3, diff="2",
    zad=[r"2.1 \quad Z kabelu dlouhého $5{,}1$ metru jsme uřízli tři půlmetrové kusy a zbytek jsme rozdělili na $12$ stejně dlouhých dílů. Určete, kolik centimetrů měří jeden díl.",
         r"2.2 \quad Vypočtěte, kolik minut jsou tři pětiny z $1$ hodiny $50$ minut."],
    solp=[r"2.1: kabel má $510\ \mathrm{cm}$; po odříznutí tří půlmetrových kusů zbývá $510-3\cdot50=360\ \mathrm{cm}$; jeden díl $360:12=30\ \mathrm{cm}$.",
          r"2.2: $1$ hodina $50$ minut $=110\ \mathrm{min}$; $\frac{3}{5}\cdot110=66\ \mathrm{min}$."],
    ans=r"2.1: $30\ \mathrm{cm}$; 2.2: $66\ \mathrm{min}$",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{1}{3}\cdot\left(5-\dfrac{13}{5}\right):20=$",
         r"3.2 \quad $\dfrac{\frac{2}{3}-\frac{3}{2}}{\frac{2}{3}:\frac{3}{2}}=$"],
    solp=[r"3.1: $5-\frac{13}{5}=\frac{25-13}{5}=\frac{12}{5}$; $\frac{1}{3}\cdot\frac{12}{5}=\frac{4}{5}$; $\frac{4}{5}:20=\frac{4}{5}\cdot\frac{1}{20}=\frac{4}{100}=\frac{1}{25}$.",
          r"3.2: čitatel $\frac{2}{3}-\frac{3}{2}=\frac{4-9}{6}=-\frac{5}{6}$; jmenovatel $\frac{2}{3}:\frac{3}{2}=\frac{2}{3}\cdot\frac{2}{3}=\frac{4}{9}$; $-\frac{5}{6}:\frac{4}{9}=-\frac{5}{6}\cdot\frac{9}{4}=-\frac{45}{24}=-\frac{15}{8}$."],
    ans=r"3.1: $\frac{1}{25}$; 3.2: $-\frac{15}{8}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 \quad Upravte a rozložte na součin vytknutím: $(4+x)\cdot x+2x^2=$",
         r"4.2 \quad Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(y-3y)\cdot(y+3y)=$",
         r"4.3 \quad Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(-n-1)^2+(1+4n)\cdot(1+4n)=$"],
    solp=[r"4.1: $(4+x)\cdot x+2x^2=4x+x^2+2x^2=3x^2+4x=x\cdot(4+3x)$.",
          r"4.2: $(y-3y)\cdot(y+3y)=(-2y)\cdot(4y)=-8y^2$.",
          r"4.3: $(-n-1)^2=n^2+2n+1$; $(1+4n)^2=16n^2+8n+1$; součet $=17n^2+10n+2$."],
    ans=r"4.1: $x\cdot(4+3x)$; 4.2: $-8y^2$; 4.3: $17n^2+10n+2$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $3\cdot(2x-1)+\dfrac{2}{3}=\dfrac{2}{3}-(x+3)$",
         r"5.2 \quad $\dfrac{y+1}{6}-\dfrac{3y}{2}=2+\dfrac{0{,}5-y}{3}$"],
    solp=[r"5.1: $6x-3+\frac{2}{3}=\frac{2}{3}-x-3$; po odečtení $\frac{2}{3}$: $6x-3=-x-3$; $7x=0$; $x=0$.",
          r"5.2: vynásobíme $6$: $(y+1)-9y=12+2\cdot(0{,}5-y)$; $-8y+1=13-2y$; $-6y=12$; $y=-2$."],
    ans=r"5.1: $x=0$; 5.2: $y=-2$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 6", pts=3, mins=5, diff="3",
    zad=[r"V hruškovém království získal každý princ tolik zlatých hrušek, kolik si zasloužil. Druhý princ získal o třetinu více hrušek než první princ a třetí princ o $12$ hrušek více než první princ. Počet zlatých hrušek, které získal první princ, označíme $x$.",
         r"6.1 \quad Vyjádřete výrazem s proměnnou $x$, kolik hrušek získal druhý princ.",
         r"6.2 \quad Vyjádřete výrazem s proměnnou $x$, kolik hrušek získal třetí princ.",
         r"6.3 \quad První a třetí princ získali dohromady dvakrát více hrušek než druhý princ. Vypočtěte, kolik hrušek získal první princ."],
    solp=[r"6.1: druhý princ $=x+\frac{x}{3}=\frac{4}{3}x$.",
          r"6.2: třetí princ $=x+12$.",
          r"6.3: $x+(x+12)=2\cdot\frac{4}{3}x$; $2x+12=\frac{8}{3}x$; vynásobíme $3$: $6x+36=8x$; $2x=36$; $x=18$."],
    ans=r"6.1: $\frac{4}{3}x$; 6.2: $x+12$; 6.3: $18$ hrušek",
    codes=["zs2", "r9", "vyrazy", "rovnice", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 7", pts=3, mins=4, diff="2",
    zad=[r"Pro soutěž Malování na chodník bylo připraveno celkem $300$ kříd zabalených v krabičkách dvou velikostí – menších a větších. V krabičkách téže velikosti byl vždy stejný počet kříd. Menších krabiček bylo pouze $5$ a celkem v nich bylo tolik kříd jako ve $3$ větších krabičkách. Každá z větších krabiček obsahovala $10$ kříd.",
         r"7.1 \quad Určete počet kříd v jedné menší krabičce.",
         r"7.2 \quad Určete počet všech větších krabiček s křídami."],
    solp=[r"7.1: ve $3$ větších krabičkách je $3\cdot10=30$ kříd; tolik je i v $5$ menších, tedy v jedné menší $30:5=6$ kříd.",
          r"7.2: v menších krabičkách je celkem $30$ kříd; ve větších $300-30=270$ kříd; větších krabiček $270:10=27$."],
    ans=r"7.1: $6$ kříd; 7.2: $27$ větších krabiček",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 8", pts=3, mins=5, diff="3",
    zad=[r"Poličku na zeď tvoří tmavá obdélníková deska podepřená dvěma stejnými bílými trojúhelníkovými deskami. Tloušťku desek zanedbáváme.",
         r"8.1 \quad Tmavý obdélník má obsah $270\ \mathrm{cm}^2$ a jeho kratší strana měří $9\ \mathrm{cm}$. Vypočtěte v cm obvod obdélníku.",
         r"8.2 \quad Oba bílé trojúhelníky jsou pravoúhlé. V trojúhelníku má jedna odvěsna délku $9\ \mathrm{cm}$ a nejdelší strana měří $15\ \mathrm{cm}$. Vypočtěte v cm$^2$ obsah jednoho trojúhelníku."],
    solp=[r"8.1: delší strana obdélníku $=270:9=30\ \mathrm{cm}$; obvod $=2\cdot(9+30)=78\ \mathrm{cm}$.",
          r"8.2: druhá odvěsna $=\sqrt{15^2-9^2}=\sqrt{225-81}=\sqrt{144}=12\ \mathrm{cm}$; obsah $=\frac{1}{2}\cdot9\cdot12=54\ \mathrm{cm}^2$."],
    ans=r"8.1: $78\ \mathrm{cm}$; 8.2: $54\ \mathrm{cm}^2$",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "slovni", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body P, Q a přímka $o$ (viz obrázek).",
         r"Body P, Q jsou vrcholy trojúhelníku PQR. Přímka $o$ je osou některé strany tohoto trojúhelníku.",
         r"Sestrojte vrchol R trojúhelníku PQR, označte ho písmenem a trojúhelník narýsujte. Najděte všechna řešení."],
    solp=[r"Osa strany trojúhelníku je osou příslušné úsečky (kolmice v jejím středu), takže krajní body této strany jsou souměrné podle přímky $o$.",
          r"Je-li $o$ osou strany PR, je vrchol R obrazem bodu P v osové souměrnosti podle $o$; je-li $o$ osou strany QR, je vrchol R obrazem bodu Q podle $o$. Sestrojíme tedy obrazy bodů P a Q v osové souměrnosti s osou $o$ a získáme dvě řešení $R_1$ a $R_2$."],
    ans=r"Dvě řešení: $R_1$ je obraz bodu P a $R_2$ je obraz bodu Q v osové souměrnosti s osou $o$.",
    svg=fig(5, (66, 118, 560, 405)), fn=FN,
    alt="V rovině leží body P a Q (vyznačené křížky) a přímka o (šikmá úsečka).", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "soumernost", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 10", pts=3, mins=7, diff="4",
    zad=[r"V rovině leží body A, X a rovnoběžné přímky $c$, $p$ (viz obrázek).",
         r"Bod A je vrchol obdélníku ABCD. Bod X leží uvnitř strany AB obdélníku. Na přímce $c$ leží vrchol C obdélníku ABCD a na přímce $p$ jeden ze zbývajících dvou vrcholů obdélníku.",
         r"Sestrojte vrcholy B, C, D obdélníku ABCD, označte je písmeny a obdélník narýsujte. Najděte všechna řešení."],
    solp=[r"Strana AB leží na přímce určené body A a X (X je vnitřní bod strany AB). Strana AD je kolmá k AB v bodě A.",
          r"Vrchol C má ležet na přímce $c$ a zároveň jeden ze zbývajících vrcholů (B, nebo D) na přímce $p$. Rozlišíme tedy dvě možnosti — na přímce $p$ leží vrchol B, nebo vrchol D — čímž z podmínky $C\in c$ dostaneme rozměry obdélníku. Úloha má dvě řešení."],
    ans=r"Dvě řešení obdélníku ABCD (strana AB na přímce AX, $AD\perp AB$, $C\in c$ a vrchol B, resp. D, na přímce $p$).",
    svg=fig(6, (66, 118, 560, 322)), fn=FN,
    alt="V rovině leží dvě rovnoběžné vodorovné přímky c a p a pod nimi body X a A (vyznačené křížky).", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 11", pts=4, mins=6, diff="4",
    zad=[r"Zahrádkář zakoupil několik kusů rostlin od každého ze čtyř druhů A, B, C a D. Některé zakoupené rostliny uschly, ostatní vzrostly. Většinu vzrostlých rostlin zahrádkář později prodal.",
         r"Graf udává počty zakoupených, vzrostlých a prodaných kusů rostlin jednotlivých druhů: druh A – zakoupené $14$, vzrostlé $12$, prodané $7$; druh B – zakoupené $9$, vzrostlé $9$, prodané $9$; druh C – zakoupené $8$, vzrostlé $8$, prodané $4$; druh D – zakoupené $11$, vzrostlé $8$, prodané $8$.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 \quad Zahrádkáři zůstalo celkem $9$ neprodaných kusů vzrostlých rostlin.",
         r"11.2 \quad Zahrádkář zakoupil o polovinu více kusů rostlin, než jich prodal.",
         r"11.3 \quad Zahrádkář prodal všechny zakoupené kusy jen u jednoho druhu rostlin."],
    solp=[r"Neprodané vzrostlé (vzrostlé $-$ prodané): A $12-7=5$, B $9-9=0$, C $8-4=4$, D $8-8=0$; celkem $5+0+4+0=9$ — 11.1 je pravdivé (\textbf{A}).",
          r"Zakoupené celkem $14+9+8+11=42$, prodané celkem $7+9+4+8=28$; $42=1{,}5\cdot28$, tedy o polovinu více — 11.2 je pravdivé (\textbf{A}).",
          r"Prodané se rovná zakoupeným pouze u druhu B ($9=9$); u A, C i D nikoli — tedy právě u jednoho druhu — 11.3 je pravdivé (\textbf{A})."],
    ans=r"11.1: A; 11.2: A; 11.3: A",
    codes=["zs2", "r9", "grafy", "aritmetika", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné a zbývající dvě jsou na sebe kolmé (viz obrázek). Úhly $2\alpha$ a $3\alpha$ jsou vyznačené u jedné z rovnoběžek, kolmost druhé dvojice přímek je vyznačena pravým úhlem.",
         r"Jaká je velikost úhlu $\beta$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Úhly $2\alpha$ a $3\alpha$ jsou vedlejší (dohromady přímý úhel): $2\alpha+3\alpha=180^\circ$, tedy $\alpha=36^\circ$ a $2\alpha=72^\circ$.",
          r"Šikmá přímka procházející tímto vrcholem svírá s rovnoběžkami úhel $2\alpha=72^\circ$. Druhá přímka je na ni kolmá, proto s rovnoběžkou svírá úhel $\beta=90^\circ-72^\circ=18^\circ$, což je méně než $20^\circ$."],
    ans=r"A) menší než $20°$",
    opts=[r"A) menší než $20°$", r"B) $20°$", r"C) $28°$", r"D) $34°$", r"E) větší než $34°$"],
    svg=fig(7, (366, 486, 558, 662)), fn=FN,
    alt="Čtyři přímky – dvě rovnoběžné (označené shodnými značkami) a dvě navzájem kolmé (pravý úhel); u jedné rovnoběžky úhly 2α a 3α, u druhé hledaný úhel β.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 13", pts=2, mins=4, diff="3",
    zad=[r"Kvádr o rozměrech $6\ \mathrm{cm}$, $4\ \mathrm{cm}$ a $5\ \mathrm{cm}$ jsme dvěma svislými řezy rozdělili na tři kolmé trojboké hranoly. Horní podstava (obdélník $6\ \mathrm{cm}\times4\ \mathrm{cm}$) je oběma řezy rozdělena na tři trojúhelníky; všechny hranoly mají výšku $5\ \mathrm{cm}$.",
         r"Z těchto trojbokých hranolů vybereme ten, který má největší objem. Jaký je objem vybraného trojbokého hranolu?"],
    solp=[r"Největší z trojúhelníků na horní podstavě má za základnu celou hranu délky $6\ \mathrm{cm}$ a příslušnou výšku $4\ \mathrm{cm}$; jeho obsah je $\frac{1}{2}\cdot6\cdot4=12\ \mathrm{cm}^2$.",
          r"Objem hranolu $=$ obsah podstavy $\times$ výška $=12\cdot5=60\ \mathrm{cm}^3$."],
    ans=r"B) $60\ \mathrm{cm}^3$",
    opts=[r"A) $40\ \mathrm{cm}^3$", r"B) $60\ \mathrm{cm}^3$", r"C) $80\ \mathrm{cm}^3$", r"D) $120\ \mathrm{cm}^3$", r"E) jiný objem"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 14", pts=2, mins=3, diff="2",
    zad=[r"Penál má tvar rotačního válce. Poloměr podstavy válce je $5\ \mathrm{cm}$ a výška válce $20\ \mathrm{cm}$. Obě podstavy válce jsou bílé a plášť válce je tmavý.",
         r"Kolikrát větší je obsah pláště válce než obsah jedné podstavy?"],
    solp=[r"Obsah pláště $S_{pl}=2\pi r h=2\pi\cdot5\cdot20=200\pi$; obsah podstavy $S_{p}=\pi r^2=\pi\cdot5^2=25\pi$.",
          r"Poměr $\frac{200\pi}{25\pi}=8$, plášť je tedy $8$krát větší."],
    ans=r"C) $8$krát",
    opts=[r"A) $4$krát", r"B) $6$krát", r"C) $8$krát", r"D) $10$krát", r"E) $20$krát"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 \quad Když firma odvezla do spalovny $60\ \%$ odpadu, zbylo jí ještě $1\,200\ \mathrm{kg}$ odpadu. Kolik kg odpadu firma odvezla do spalovny?",
         r"15.2 \quad Stejné dlaždice byly umístěny ve stejném počtu na dvou paletách. Již se prodaly dvě pětiny dlaždic z první palety a $10\ \%$ dlaždic z druhé palety. Hmotnost všech těchto prodaných dlaždic byla $750\ \mathrm{kg}$. Kolik kg váží dosud neprodané dlaždice z obou palet?",
         r"15.3 \quad Ve sběrných surovinách vykoupili v létě $1\,500\ \mathrm{kg}$ kovů, což je o $50\ \%$ více než na jaře a o $50\ \%$ méně než na podzim. O kolik kg kovů vykoupili na podzim více než na jaře?",
         r"Nabídka: A) $1\,500\ \mathrm{kg}$; B) $1\,800\ \mathrm{kg}$; C) $2\,000\ \mathrm{kg}$; D) $2\,100\ \mathrm{kg}$; E) $2\,250\ \mathrm{kg}$; F) jiný počet kg."],
    solp=[r"15.1: zbytek $1\,200\ \mathrm{kg}$ je $40\ \%$ celku, celkem $1\,200:0{,}4=3\,000\ \mathrm{kg}$; odvezeno $60\ \%$, tj. $0{,}6\cdot3\,000=1\,800\ \mathrm{kg}$ — \textbf{B}.",
          r"15.2: na jedné paletě hmotnost $M$; prodáno $\frac{2}{5}M+\frac{1}{10}M=\frac{1}{2}M=750\Rightarrow M=1\,500\ \mathrm{kg}$; obě palety $3\,000\ \mathrm{kg}$; neprodané $3\,000-750=2\,250\ \mathrm{kg}$ — \textbf{E}.",
          r"15.3: léto $1\,500=1{,}5\cdot$ jaro $\Rightarrow$ jaro $1\,000\ \mathrm{kg}$; léto $=0{,}5\cdot$ podzim $\Rightarrow$ podzim $3\,000\ \mathrm{kg}$; rozdíl $3\,000-1\,000=2\,000\ \mathrm{kg}$ — \textbf{C}."],
    ans=r"15.1: B; 15.2: E; 15.3: C",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9C · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Výsledný obrazec vytvoříme tímto postupem: 1. Na vodorovné přímce sestrojíme několik stejně vzdálených bodů (černých puntíků). 2. Prvním černým puntíkem vedeme dvě různoběžné šikmé přímky; druhým a každým dalším černým puntíkem vedeme rovnoběžky s oběma těmito přímkami. 3. Všechny nově vzniklé průsečíky označíme černými puntíky a těmi vedeme vodorovné přímky. 4. Na spodní vodorovné přímce označíme všechny nově vzniklé průsečíky bílými puntíky.",
         r"16.1 \quad Výsledný obrazec obsahuje celkem $36$ černých puntíků. Určete počet všech vodorovných přímek v tomto obrazci.",
         r"16.2 \quad Výsledný obrazec obsahuje celkem $49$ vodorovných přímek. Určete počet bílých puntíků na spodní vodorovné přímce tohoto obrazce.",
         r"16.3 \quad Výsledný obrazec má na spodní vodorovné přímce celkem $64$ bílých puntíků. Určete počet všech černých puntíků v tomto obrazci."],
    solp=[r"Je-li na počáteční přímce $n$ černých puntíků, vytvoří obě soustavy rovnoběžek mřížku s $n^2$ průsečíky, takže černých puntíků je $n^2$. Průsečíky leží v $2n-1$ různých výškách, proto je vodorovných přímek $2n-1$. Spodní vodorovná přímka protíná šikmé přímky v $2n-1$ bodech, z nichž jeden (nejnižší vrchol) je již černý puntík, takže bílých puntíků je $2n-2$.",
          r"16.1: $n^2=36\Rightarrow n=6$; vodorovných přímek $2\cdot6-1=11$.",
          r"16.2: $2n-1=49\Rightarrow n=25$; bílých puntíků $2\cdot25-2=48$.",
          r"16.3: $2n-2=64\Rightarrow n=33$; černých puntíků $33^2=1\,089$."],
    ans=r"16.1: $11$ vodorovných přímek; 16.2: $48$ bílých puntíků; 16.3: $1\,089$ černých puntíků",
    codes=["zs2", "r9", "posloupnosti", "algebra", "uvazovani", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9C-2022")
for path, size, names in written:
    print("%s  (%d B, %d úloh)" % (path, size, len(names)))
