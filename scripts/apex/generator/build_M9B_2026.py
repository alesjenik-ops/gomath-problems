# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9B 2026 (2. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9B_2026_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2026, 2. řádný termín (M9B)"
CCODE = "M9PBD26C0T02"
YR = 2026
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2026 M9B · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte, o kolik $\mathrm{cm}^2$ je plocha o obsahu $0{,}1\ \mathrm{m}^2$ větší než plocha o obsahu $20\ \mathrm{cm}^2$."],
    solp=[r"$0{,}1\ \mathrm{m}^2 = 1000\ \mathrm{cm}^2$.", r"$1000 - 20 = 980\ \mathrm{cm}^2$."],
    ans=r"o $980\ \mathrm{cm}^2$",
    codes=["zs2", "r9", "aritmetika", "desetinna-cisla", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 2", pts=4, mins=5, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem:",
         r"2.1 \quad $3\cdot\left(\dfrac{2}{3}-\dfrac{7}{9}\right)+\dfrac{2}{3}=$",
         r"2.2 \quad $1:\dfrac{6}{5}-\dfrac{1}{6}:5=$",
         r"2.3 \quad $\dfrac{1-\frac{1}{4}}{2\cdot\frac{5}{8}-2}=$"],
    solp=[r"2.1: $3\cdot\left(\frac{6}{9}-\frac{7}{9}\right)+\frac{2}{3}=3\cdot\left(-\frac{1}{9}\right)+\frac{2}{3}=-\frac{1}{3}+\frac{2}{3}=\frac{1}{3}$.",
          r"2.2: $1:\frac{6}{5}-\frac{1}{6}:5=\frac{5}{6}-\frac{1}{30}=\frac{25}{30}-\frac{1}{30}=\frac{24}{30}=\frac{4}{5}$.",
          r"2.3: čitatel $1-\frac{1}{4}=\frac{3}{4}$, jmenovatel $2\cdot\frac{5}{8}-2=\frac{5}{4}-2=-\frac{3}{4}$; $\frac{3}{4}:\left(-\frac{3}{4}\right)=-1$."],
    ans=r"2.1: $\frac{1}{3}$; 2.2: $\frac{4}{5}$; 2.3: $-1$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"3.1 Upravte na co nejjednodušší tvar bez závorek: $5x-3x\cdot3-3\cdot(-2x)=$",
         r"3.2 Upravte a rozložte na součin vytknutím: $(a-2b)\cdot b-b+2b^2=$",
         r"3.3 Upravte na co nejjednodušší tvar bez závorek: $(3y+y)\cdot(y-1)+(1-2y)\cdot(2y+1)=$"],
    solp=[r"3.1: $5x-9x+6x=2x$.",
          r"3.2: $(a-2b)b-b+2b^2=ab-2b^2-b+2b^2=ab-b=b\cdot(a-1)$.",
          r"3.3: $(4y)(y-1)+(1-2y)(2y+1)=4y^2-4y+(1-4y^2)=1-4y$."],
    ans=r"3.1: $2x$; 3.2: $b\cdot(a-1)$; 3.3: $1-4y$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnici:",
         r"4.1 \quad $\dfrac{1}{2}\cdot(3x+4)+5=\dfrac{1}{2}\cdot(2-x)$",
         r"4.2 \quad $\dfrac{6+y}{5}=7-\dfrac{8+5y}{20}$"],
    solp=[r"4.1: vynásobíme $2$: $3x+4+10=2-x\Rightarrow 3x+14=2-x\Rightarrow 4x=-12\Rightarrow x=-3$.",
          r"4.2: vynásobíme $20$: $4(6+y)=140-(8+5y)\Rightarrow 24+4y=132-5y\Rightarrow 9y=108\Rightarrow y=12$."],
    ans=r"4.1: $x=-3$; 4.2: $y=12$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 5", pts=3, mins=4, diff="3",
    zad=[r"František dal do svého salátu obsahujícího $850\ \mathrm{g}$ rajčat celkem $255\ \mathrm{g}$ cukru. Podle receptu však do salátu patří na každých $250\ \mathrm{g}$ rajčat pouze $25\ \mathrm{g}$ cukru.",
         r"5.1 Vypočtěte, kolik gramů cukru měl dát František podle receptu do svého salátu.",
         r"5.2 Vypočtěte, o kolik procent více cukru dal František do svého salátu, než měl dát podle receptu."],
    solp=[r"5.1: na $850\ \mathrm{g}$ rajčat je $\frac{850}{250}\cdot25=3{,}4\cdot25=85\ \mathrm{g}$ cukru.",
          r"5.2: $255:85=3$, tedy dal $300\ \%$ doporučeného množství, což je o $200\ \%$ více."],
    ans=r"5.1: $85\ \mathrm{g}$; 5.2: o $200\ \%$ více",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "s-kalkulackou", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 6", pts=4, mins=6, diff="3",
    zad=[r"Na vánočním jarmarku prodávali ve stánku pouze čaj a punč. Čaj prodávali za $40$ korun a cena punče byla o $75\ \%$ vyšší než cena čaje.",
         r"6.1 Vypočtěte v korunách cenu jednoho punče.",
         r"6.2 Počet čajů, které dnes ve stánku prodali, označíme $x$. Vyjádřete výrazem s proměnnou $x$, kolik korun dnes ve stánku utržili za všechny prodané čaje.",
         r"6.3 Ve stánku dnes prodali celkem $510$ nápojů a utržili za ně dohromady $29\,700$ korun. Vypočtěte, kolik čajů prodali dnes ve stánku."],
    solp=[r"6.1: $40\cdot1{,}75=70$ korun.",
          r"6.2: $40x$ korun.",
          r"6.3: čajů $x$, punčů $510-x$: $40x+70(510-x)=29\,700\Rightarrow -30x=-6000\Rightarrow x=200$."],
    ans=r"6.1: $70$ korun; 6.2: $40x$; 6.3: $200$ čajů",
    codes=["zs2", "r9", "procenta", "rovnice", "slovni", "modelovani", "s-kalkulackou", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 7", pts=3, mins=5, diff="4",
    zad=[r"Kruh o poloměru $10\ \mathrm{cm}$ je rozdělen na tři shodné bílé části a tři shodné šedé části jako na obrázku.",
         r"7.1 Určete, kolikrát je obsah jedné bílé části kruhu větší než obsah jedné šedé části.",
         r"7.2 Vypočtěte v cm obvod jedné bílé části kruhu. Výsledek zaokrouhlete na desetiny centimetru."],
    solp=[r"Jedna bílá část je kruhová výseč se středovým úhlem $90^\circ$, jedna šedá výseč má úhel $30^\circ$.",
          r"7.1: poměr obsahů je $90:30=3$, bílá část je $3$krát větší.",
          r"7.2: obvod $=$ dva poloměry $+$ čtvrtinový oblouk $=2\cdot10+\frac{1}{4}\cdot2\pi\cdot10\doteq20+15{,}7=35{,}7\ \mathrm{cm}$."],
    ans=r"7.1: $3$krát; 7.2: $35{,}7\ \mathrm{cm}$",
    svg=fig(4, (338, 66, 562, 236)), fn=FN,
    alt="Kruh o poloměru 10 cm rozdělený na tři shodné bílé a tři shodné šedé části; vpravo je vyznačena jedna bílá část.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 8", pts=2, mins=3, diff="3",
    zad=[r"Délky dvou stran trojúhelníku $ABC$ jsou $a=7\ \mathrm{cm}$, $b=30\ \mathrm{cm}$. Obvod trojúhelníku $ABC$ v cm je vyjádřen celým číslem.",
         r"Určete, kolik cm musí měřit strana $c$ trojúhelníku $ABC$, aby byl jeho obvod",
         r"8.1 nejmenší možný,",
         r"8.2 největší možný."],
    solp=[r"Trojúhelníková nerovnost: $b-a<c<b+a$, tedy $23<c<37$.",
          r"8.1: nejmenší celé $c=24\ \mathrm{cm}$ (obvod $61\ \mathrm{cm}$).",
          r"8.2: největší celé $c=36\ \mathrm{cm}$ (obvod $73\ \mathrm{cm}$)."],
    ans=r"8.1: $24\ \mathrm{cm}$; 8.2: $36\ \mathrm{cm}$",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 9", pts=2, mins=5, diff="3",
    zad=[r"V rovině leží body $A$, $O$, $P$ (viz obrázek).",
         r"Bod $A$ je vrchol pravidelného šestiúhelníku $ABCDEF$. Přímka $OP$ je osa strany $AB$ tohoto šestiúhelníku. Na polopřímce $OP$ leží střed souměrnosti $S$ šestiúhelníku $ABCDEF$.",
         r"Sestrojte vrcholy $B$, $C$, $D$, $E$, $F$ šestiúhelníku $ABCDEF$, označte je písmeny a šestiúhelník narýsujte."],
    solp=[r"Osa $OP$ je osou souměrnosti šestiúhelníku, bod $B$ je obrazem bodu $A$ v této ose, proto $B$ získáme osovou souměrností $A$ podle přímky $OP$.",
          r"U pravidelného šestiúhelníku je poloměr kružnice opsané roven délce strany, tedy $|SA|=|AB|$. Střed $S$ leží na $OP$ ve vzdálenosti $|SA|=|AB|$ od $A$.",
          r"Zbývající vrcholy $C$, $D$, $E$, $F$ dostaneme nanášením délky strany $|AB|$ po kružnici se středem $S$ a poloměrem $|SA|$."],
    ans=r"Pravidelný šestiúhelník $ABCDEF$ se středem $S$ na polopřímce $OP$; $B$ je obraz $A$ v ose $OP$ a $|SA|=|AB|$ (viz postup konstrukce).",
    svg=fig(5, (66, 90, 528, 360)), fn=FN,
    alt="Tři body A, O, P v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $A$, $B$, $D$ (viz obrázek).",
         r"Body $A$ a $B$ jsou vrcholy pravoúhlého trojúhelníku $ABC$ s pravým úhlem při vrcholu $C$. Body $B$ a $D$ jsou vrcholy pravoúhlého trojúhelníku $BCD$ s pravým úhlem při vrcholu $C$. (Vrcholy $B$ a $C$ jsou společnými vrcholy obou trojúhelníků.)",
         r"Sestrojte vrchol $C$, označte ho písmenem a narýsujte trojúhelníky $ABC$ a $BCD$."],
    solp=[r"Pravý úhel u $C$ v trojúhelníku $ABC$ znamená, že $C$ leží na Thaletově kružnici nad průměrem $AB$.",
          r"Pravý úhel u $C$ v trojúhelníku $BCD$ znamená, že $C$ leží na Thaletově kružnici nad průměrem $BD$.",
          r"Bod $C$ je průsečík obou Thaletových kružnic; ve správném řešení leží $C$ na polopřímce $DA$ a úhel $DCB$ je pravý."],
    ans=r"Bod $C$ je průsečík Thaletových kružnic nad $AB$ a nad $BD$; leží na polopřímce $DA$ a úhel $DCB$ je pravý (viz konstrukce).",
    svg=fig(6, (66, 66, 528, 380)), fn=FN,
    alt="Tři body A, B, D v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 11", pts=4, mins=5, diff="3",
    zad=[r"Na parkovišti mohou auta stát jeden den nebo zůstat zaparkovaná nepřetržitě více dnů. Na noc se parkoviště pro vjezd a výjezd uzavírá. V grafu jsou znázorněny počty aut na parkovišti v průběhu pěti dnů, čtyři údaje však chybí.",
         r"Např. v pátek bylo na parkovišti již před otevřením $9$ aut, která tam zůstala z předchozích dnů, během dne pak přibylo $12$ nově zaparkovaných aut. Z těchto $21$ aut v pátek $3$ auta ukončila parkování a odjela.",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"11.1 V pondělí bylo na parkovišti již před otevřením právě $10$ aut.",
         r"11.2 Ve středu na parkovišti nově zaparkovalo $9$ aut.",
         r"11.3 Ve čtvrtek ukončilo parkování méně než $12$ aut."],
    solp=[r"Počet aut zůstávajících na další den $=$ (auta z předchozích dnů) $+$ (nově zaparkovaná) $-$ (odjetá).",
          r"11.1: v pondělí nemohla být žádná auta z předchozích dnů (jde o první den), tvrzení je nepravdivé — N.",
          r"11.2: ve středu nově zaparkovalo $9$ aut — A.",
          r"11.3: ve čtvrtek ukončilo parkování $12$ aut, nikoli méně — N."],
    ans=r"11.1: N; 11.2: A; 11.3: N",
    svg=fig(7, (86, 112, 506, 432)), fn=FN,
    alt="Sloupcový graf počtu aut na parkovišti během pěti dnů (pondělí–pátek) se třemi kategoriemi: auta z předchozích dnů, nově zaparkovaná a odjíždějící; čtyři údaje chybí.",
    cap="",
    codes=["zs2", "r9", "statistika", "porozumeni", "slovni", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 12", pts=2, mins=4, diff="3",
    zad=[r"V trojúhelníkovém diagramu se do prázdných kroužků doplní taková kladná celá čísla, aby byl součin tří čísel na každé straně trojúhelníku stejný (viz obrázek).",
         r"Jaký je součet obou čísel doplněných do prázdných kroužků diagramu?"],
    opts=[r"A) $11$", r"B) $14$", r"C) $19$", r"D) $22$", r"E) jiný součet"],
    solp=[r"Označme horní levý kroužek $t$ a dolní kroužek $b$. Součin na horní straně je $t\cdot6\cdot8=48t$, na pravé $8\cdot5\cdot b=40b$, na levé $t\cdot4\cdot b$.",
          r"Z $48t=4tb$ plyne $b=12$; z $48t=40b=480$ plyne $t=10$.",
          r"Součet doplněných čísel je $t+b=10+12=22$."],
    ans=r"D) $22$",
    svg=fig(8, (366, 56, 534, 205)), fn=FN,
    alt="Trojúhelníkový diagram se šesti kroužky; vyplněná čísla 6, 8, 4, 5 a dva prázdné kroužky.",
    cap="",
    codes=["zs2", "r9", "aritmetika", "algebra", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 13", pts=2, mins=4, diff="3",
    zad=[r"Z krychle o hraně délky $10\ \mathrm{cm}$ byly vyříznuty čtyři shodné malé krychličky o hraně délky $2\ \mathrm{cm}$. Vzniklo tak nové těleso (viz obrázek).",
         r"Jaký je povrch nového tělesa?"],
    opts=[r"A) $552\ \mathrm{cm}^2$", r"B) $584\ \mathrm{cm}^2$", r"C) $600\ \mathrm{cm}^2$", r"D) $616\ \mathrm{cm}^2$", r"E) jiný povrch"],
    solp=[r"Vyříznutím malé krychle z hrany (rohu) velké krychle ubydou z povrchu tři stěny krychličky, ale přibudou tři stejně velké stěny uvnitř výřezu.",
          r"Povrch se proto nezmění a zůstává roven povrchu původní krychle: $6\cdot10^2=600\ \mathrm{cm}^2$."],
    ans=r"C) $600\ \mathrm{cm}^2$",
    svg=fig(8, (298, 438, 534, 560)), fn=FN,
    alt="Krychle o hraně 10 cm a nové těleso vzniklé vyříznutím čtyř malých krychliček o hraně 2 cm.",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 14", pts=2, mins=4, diff="4",
    zad=[r"Pomocí hrnku naléváme do prázdného kanystru vodu ze studánky. Po nalití $28$ hrnků plných vody bylo zaplněno sedm osmin objemu kanystru. Když jsme přilili ještě $1$ hrnek plný vody, do úplného zaplnění kanystru chybělo $1\,050\ \mathrm{ml}$ vody.",
         r"Jaký je objem hrnku?"],
    opts=[r"A) $350\ \mathrm{ml}$", r"B) $300\ \mathrm{ml}$", r"C) $245\ \mathrm{ml}$", r"D) $210\ \mathrm{ml}$", r"E) jiný objem"],
    solp=[r"Nechť $V$ je objem kanystru. Z $28$ hrnků $=\frac{7}{8}V$ plyne objem jednoho hrnku $\frac{V}{32}$.",
          r"Po $29$ hrncích chybí $V-\frac{29}{32}V=\frac{3}{32}V=1\,050\ \mathrm{ml}$, tedy $V=11\,200\ \mathrm{ml}$.",
          r"Objem hrnku je $\frac{V}{32}=350\ \mathrm{ml}$."],
    ans=r"A) $350\ \mathrm{ml}$",
    codes=["zs2", "r9", "zlomky", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 15", pts=6, mins=6, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Bedna s jablky váží $20\ \mathrm{kg}$ a je o $25\ \%$ těžší než bedna s hruškami. Kolik kg váží bedna s hruškami?",
         r"15.2 Z nasbíraných jahod jsme $65\ \%$ použili na výrobu džemu, $20\ \%$ na výrobu sirupu a zbývající $3\ \mathrm{kg}$ jsme zamrazili. Kolik kg jahod jsme použili na výrobu džemu?",
         r"15.3 Celková hmotnost dvou zavazadel je $42\ \mathrm{kg}$. Menší zavazadlo je o $60\ \%$ lehčí než větší zavazadlo. O kolik kg se liší hmotnosti obou zavazadel?"],
    opts=[r"A) $12\ \mathrm{kg}$", r"B) $13\ \mathrm{kg}$", r"C) $15\ \mathrm{kg}$", r"D) $16\ \mathrm{kg}$", r"E) $18\ \mathrm{kg}$", r"F) jiný počet kg"],
    solp=[r"15.1: $20:1{,}25=16\ \mathrm{kg}$ — D.",
          r"15.2: zamrazená $3\ \mathrm{kg}$ jsou $15\ \%$, celkem $20\ \mathrm{kg}$; džem $65\ \%$ z $20=13\ \mathrm{kg}$ — B.",
          r"15.3: větší $v$, menší $0{,}4v$; $1{,}4v=42\Rightarrow v=30$, menší $12$; rozdíl $18\ \mathrm{kg}$ — E."],
    ans=r"15.1: D) $16\ \mathrm{kg}$; 15.2: B) $13\ \mathrm{kg}$; 15.3: E) $18\ \mathrm{kg}$",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "s-kalkulackou", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2026 M9B · úloha 16", pts=4, mins=6, diff="4",
    zad=[r"První obrazec je bílý čtverec. Druhý obrazec vznikne z prvního vložením menšího šedého čtverce, jehož vrcholy leží ve středech stran bílého čtverce. Další obrazce vznikají střídavým vkládáním stále menších bílých a šedých čtverců (viz obrázek). Např. třetí obrazec obsahuje $9$ dílů — $1$ bílý čtverec, $4$ šedé trojúhelníky a $4$ bílé trojúhelníky.",
         r"16.1 Určete, kolik šedých dílů obsahuje $10.$ obrazec.",
         r"16.2 Určete, kolikátý obrazec obsahuje $89$ bílých dílů.",
         r"16.3 Vyjádřete zlomkem, jakou část obsahu $5.$ obrazce představuje obsah všech jeho šedých dílů dohromady."],
    solp=[r"V $n$-tém obrazci ($n\ge2$) je počet šedých dílů $2n-3$ a počet bílých dílů $2n-1$ (u prvního obrazce je $1$ bílý díl).",
          r"16.1: $2\cdot10-3=17$ šedých dílů.",
          r"16.2: $2n-1=89\Rightarrow n=45$, tedy $45.$ obrazec.",
          r"16.3: každým vložením se obsah nového čtverce zmenší na polovinu; šedé díly $5.$ obrazce mají dohromady obsah $\frac{5}{16}$ obsahu celého čtverce."],
    ans=r"16.1: $17$ šedých dílů; 16.2: $45.$ obrazec; 16.3: $\frac{5}{16}$",
    svg=fig(10, (62, 173, 528, 298)), fn=FN,
    alt="Posloupnost čtyř obrazců z vnořených bílých a šedých čtverců (1. až 4. obrazec).",
    cap="",
    codes=["zs2", "r9", "posloupnosti", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9B-2026")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d znaků, %d úloh" % (path, size, len(names)))
