# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9B 2017 (2. řádný termín)."""
import os, re, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9B_2017_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2017, 2. řádný termín (M9B)"
CCODE = "M9PBD17C0T02"
YR = 2017
FN = "obr.svg"


def fig(pi, rect, strip_text=False):
    # Some figure/label spans in this 2017 PDF decode to control chars
    # (e.g. β -> U+0010), which break XML; strip <text> from those and
    # convey the labels in the zadání instead.
    s = region_svg(PDF, pi, rect)
    if strip_text:
        s = re.sub(r"<text.*?</text>", "", s)
    return s


P = []

P.append(dict(
    name="CERMAT 2017 M9B · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Určete číslo, které musíme odečíst od výrazu $\sqrt{1+\dfrac{9}{16}}$, abychom získali výsledek $0{,}5$."],
    solp=[r"$\sqrt{1+\frac{9}{16}}=\sqrt{\frac{25}{16}}=\frac{5}{4}=1{,}25$; hledané číslo je $1{,}25-0{,}5=0{,}75=\frac{3}{4}$."],
    ans=r"$\frac{3}{4}$ (tj. $0{,}75$)",
    codes=["zs2", "r9", "aritmetika", "zlomky", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 2", pts=2, mins=3, diff="2",
    zad=[r"Vypočtěte:",
         r"2.1 \quad $0{,}5:0{,}5^2=$",
         r"2.2 \quad $6\cdot\dfrac{-15-6\cdot(-2)}{2}=$"],
    solp=[r"2.1: $0{,}5:0{,}25=2$.",
          r"2.2: čitatel $-15-6\cdot(-2)=-15+12=-3$; $6\cdot\frac{-3}{2}=6\cdot(-1{,}5)=-9$."],
    ans=r"2.1: $2$; 2.2: $-9$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $2-\dfrac{1}{3}-\dfrac{1}{6}\cdot\dfrac{16}{3}=$",
         r"3.2 \quad $\dfrac{\frac{7}{10}-\frac{2}{5}:\frac{1}{10}}{20\cdot\frac{3}{10}}=$"],
    solp=[r"3.1: $\frac{1}{6}\cdot\frac{16}{3}=\frac{16}{18}=\frac{8}{9}$; $2-\frac{1}{3}-\frac{8}{9}=\frac{18-3-8}{9}=\frac{7}{9}$.",
          r"3.2: čitatel $\frac{7}{10}-\frac{2}{5}:\frac{1}{10}=\frac{7}{10}-\frac{2}{5}\cdot10=\frac{7}{10}-4=-\frac{33}{10}$; jmenovatel $20\cdot\frac{3}{10}=6$; $-\frac{33}{10}:6=-\frac{33}{60}=-\frac{11}{20}$."],
    ans=r"3.1: $\frac{7}{9}$; 3.2: $-\frac{11}{20}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"Zjednodušte (výsledný výraz nesmí obsahovat závorky):",
         r"4.1 \quad $(x-4)^2+(8-2x)\cdot2x=$",
         r"4.2 \quad $(a+2a)\cdot(a-2a)-(a-2a)=$"],
    solp=[r"4.1: $(x-4)^2=x^2-8x+16$; $(8-2x)\cdot2x=16x-4x^2$; součet $x^2-8x+16+16x-4x^2=-3x^2+8x+16$.",
          r"4.2: $(a+2a)=3a$, $(a-2a)=-a$; $3a\cdot(-a)-(-a)=-3a^2+a=a-3a^2$."],
    ans=r"4.1: $-3x^2+8x+16$; 4.2: $a-3a^2$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $4x+1=4\cdot(4x+0{,}25)$",
         r"5.2 \quad $\dfrac{x-5}{2}+x=\dfrac{2x}{3}-\dfrac{5}{6}$"],
    solp=[r"5.1: $4x+1=16x+1\Rightarrow4x=16x\Rightarrow12x=0\Rightarrow x=0$.",
          r"5.2: vynásobíme $6$: $3(x-5)+6x=4x-5\Rightarrow3x-15+6x=4x-5\Rightarrow9x-15=4x-5\Rightarrow5x=10\Rightarrow x=2$."],
    ans=r"5.1: $x=0$; 5.2: $x=2$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 6", pts=4, mins=6, diff="3",
    zad=[r"V promítacím sále bylo přítomno $100$ platících osob. Cena vstupenky pro dospělého je $200$ Kč, pro dítě $150$ Kč. V pokladně vybrali za vstupenky $16\,000$ Kč.",
         r"6.1 Vypočtěte, o kolik procent je vstupenka pro dítě levnější než vstupenka pro dospělého.",
         r"6.2 Vypočtěte, kolik dětí bylo v promítacím sále.",
         r"6.3 Vypočtěte, kolik Kč vybrali v pokladně za vstupné pro dospělé."],
    solp=[r"6.1: $\frac{200-150}{200}=\frac{50}{200}=0{,}25=25\ \%$.",
          r"6.2: je-li $d$ počet dětí, pak $200\cdot(100-d)+150d=16\,000\Rightarrow20\,000-50d=16\,000\Rightarrow50d=4\,000\Rightarrow d=80$ dětí.",
          r"6.3: dospělých bylo $100-80=20$; za dospělé vybrali $20\cdot200=4\,000$ Kč."],
    ans=r"6.1: o $25\ \%$; 6.2: $80$ dětí; 6.3: $4\,000$ Kč",
    codes=["zs2", "r9", "procenta", "rovnice", "aritmetika", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 7", pts=3, mins=5, diff="3",
    zad=[r"Na kružnici $k$ s poloměrem $r=5\ \mathrm{cm}$ (kde $r=|SA|$) leží vrcholy obdélníku $ABCD$. Delší strana obdélníku měří $8\ \mathrm{cm}$. Úhlopříčky obdélníku se protínají ve středu $S$ kružnice (viz obrázek).",
         r"7.1 Vypočtěte délku kružnice a výsledek v cm zaokrouhlete na desetiny.",
         r"7.2 Vypočtěte v cm obvod obdélníku $ABCD$."],
    solp=[r"7.1: délka (obvod) kružnice $o=2\pi r=2\pi\cdot5=10\pi\doteq31{,}4\ \mathrm{cm}$.",
          r"7.2: úhlopříčka obdélníku je průměr kružnice, tedy $|AC|=2r=10\ \mathrm{cm}$; kratší strana $\sqrt{10^2-8^2}=\sqrt{36}=6\ \mathrm{cm}$; obvod $2\cdot(8+6)=28\ \mathrm{cm}$."],
    ans=r"7.1: $o\doteq31{,}4\ \mathrm{cm}$; 7.2: obvod $=28\ \mathrm{cm}$",
    svg=fig(3, (85, 558, 205, 676)), fn=FN,
    alt="Kružnice k se středem S a poloměrem r; do kružnice je vepsán obdélník ABCD s úhlopříčkami procházejícími středem S, delší strana DC měří 8 cm.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 8", pts=3, mins=5, diff="3",
    zad=[r"Doplňte do rámečku čísla tak, aby platila rovnost (rámeček je značen jako $\square$):",
         r"8.1 \quad $3\ \mathrm{dm}^2=1\ \mathrm{dm}^2+\square\ \mathrm{cm}^2$",
         r"8.2 \quad $1{,}2\ \mathrm{litru}=\square\ \mathrm{dm}^3-100\ \mathrm{cm}^3$",
         r"8.3 \quad $\square\cdot1{,}5\ \mathrm{hodiny}+20\ \mathrm{minut}=1\ \mathrm{hodina}\ 5\ \mathrm{minut}$"],
    solp=[r"8.1: $3\ \mathrm{dm}^2-1\ \mathrm{dm}^2=2\ \mathrm{dm}^2=200\ \mathrm{cm}^2$; do rámečku patří $200$.",
          r"8.2: $1{,}2\ \mathrm{litru}=1{,}2\ \mathrm{dm}^3=1\,200\ \mathrm{cm}^3$; $1\,200+100=1\,300\ \mathrm{cm}^3=1{,}3\ \mathrm{dm}^3$; do rámečku patří $1{,}3$.",
          r"8.3: $1\ \mathrm{hodina}\ 5\ \mathrm{minut}=65\ \mathrm{minut}$; $65-20=45\ \mathrm{minut}$; $45:90=0{,}5$; do rámečku patří $0{,}5$."],
    ans=r"8.1: $200$; 8.2: $1{,}3$; 8.3: $0{,}5$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 9", pts=2, mins=4, diff="3",
    zad=[r"V rovině leží trojúhelník $RST$ (viz obrázek).",
         r"Sestrojte obraz $R_1S_1T_1$ trojúhelníku $RST$ ve středové souměrnosti se středem $S$. Všechny vrcholy trojúhelníku $R_1S_1T_1$ označte."],
    solp=[r"Ve středové souměrnosti se středem $S$ se bod $S$ zobrazí sám na sebe, tedy $S_1=S$. Obraz $R_1$ leží na polopřímce opačné k $SR$ tak, že $|SR_1|=|SR|$; obdobně $T_1$ leží na polopřímce opačné k $ST$ tak, že $|ST_1|=|ST|$. Body $R_1$, $S_1=S$, $T_1$ spojíme.",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Obraz $R_1S_1T_1$ ve středové souměrnosti se středem $S$ (platí $S_1=S$; $R_1$ a $T_1$ jsou souměrně sdružené s $R$ a $T$ podle středu $S$).",
    svg=fig(4, (100, 442, 380, 555)), fn=FN,
    alt="V rovině leží trojúhelník RST: vrchol R vlevo dole, S dole uprostřed, T vpravo nahoře.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"Kružnici $k$ se středem $S$ protíná přímka ve dvou bodech $C$ a $D$ (viz obrázek).",
         r"Body $C$, $D$ jsou vrcholy rovnoramenného lichoběžníku $ABCD$. Všechny čtyři vrcholy tohoto lichoběžníku leží na kružnici $k$. Vzdálenost chybějících vrcholů $A$, $B$ od přímky $CD$ je rovna poloměru $r=|SC|$ kružnice $k$.",
         r"10.1 Sestrojte vrcholy $A$, $B$ lichoběžníku $ABCD$ a lichoběžník narýsujte.",
         r"10.2 Sestrojte osu souměrnosti lichoběžníku $ABCD$ (pokud existuje) a označte ji $o$.",
         r"10.3 Sestrojte výšku lichoběžníku $ABCD$ z vrcholu $D$ a označte ji $v$."],
    solp=[r"Vrcholy $A$, $B$ leží na kružnici $k$ a jejich vzdálenost od přímky $CD$ je $r$. Sestrojíme rovnoběžku s $CD$ ve vzdálenosti $r$ (na té straně, kde vznikne lichoběžník) a její průsečíky s kružnicí $k$ jsou hledané body $A$ a $B$. Vrcholy spojíme do rovnoramenného lichoběžníku $ABCD$ se základnami $AB\parallel CD$.",
          r"Osa souměrnosti $o$ rovnoramenného lichoběžníku je osa obou základen (prochází středem $S$ kolmo k $CD$ i $AB$). Výška $v$ z vrcholu $D$ je kolmice vedená z bodu $D$ k základně $AB$.",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce rovnoramenného lichoběžníku $ABCD$ vepsaného do $k$ ($A$, $B$ na $k$ ve vzdálenosti $r$ od $CD$), osa souměrnosti $o$ (osa základen procházející $S$) a výška $v$ z vrcholu $D$.",
    svg=fig(5, (130, 148, 450, 425)), fn=FN,
    alt="Kružnice k se středem S; přímka protíná kružnici v bodech C a D, vyznačena je úsečka SC (poloměr r).", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 11", pts=4, mins=5, diff="3",
    zad=[r"Balení, které obsahuje $15\ \mathrm{kg}$ granulí, vystačí čtyřem psům na $15$ dnů. Všichni čtyři psi dostávají denně stejné množství granulí.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 Jeden pes dostává denně $250\ \mathrm{g}$ granulí.",
         r"11.2 Pouze dvěma psům by $15\mathrm{kg}$ balení granulí vystačilo na $30$ dnů.",
         r"11.3 Jednomu psovi vystačí desetina $15\mathrm{kg}$ balení granulí na $10$ dnů."],
    solp=[r"Denní spotřeba všech čtyř psů: $15\,000\ \mathrm{g}:15=1\,000\ \mathrm{g}$ za den; jeden pes tedy $1\,000:4=250\ \mathrm{g}$ za den.",
          r"11.1: jeden pes $250\ \mathrm{g}$ denně — \textbf{A} (pravda).",
          r"11.2: dva psi spotřebují $2\cdot250=500\ \mathrm{g}$ denně; $15\,000:500=30$ dnů — \textbf{A}.",
          r"11.3: desetina balení $=1\,500\ \mathrm{g}$; jeden pes $250\ \mathrm{g}$ denně, tj. $1\,500:250=6$ dnů (ne $10$) — \textbf{N}."],
    ans=r"11.1: A; 11.2: A; 11.3: N",
    codes=["zs2", "r9", "aritmetika", "pomer", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"V trojúhelníku (viz obrázek) je vyznačena vnitřní úsečka spojující bod na základně s bodem na pravé straně trojúhelníku. Dvojité čárky vyznačují dvě shodné (stejně dlouhé) úsečky — část levé strany a tuto vnitřní úsečku. Úhel při levém dolním vrcholu má velikost $52^\circ$; vnitřní úsečka svírá s pravou stranou trojúhelníku (směrem k hornímu vrcholu) úhel $88^\circ$. Úhel při pravém dolním vrcholu je $\beta$.",
         r"Jaká je velikost úhlu $\beta$? Úhel neměřte, ale vypočtěte."],
    solp=[r"Ze shodných úseček plyne, že vnitřní úsečka je rovnoběžná s levou stranou trojúhelníku. Se základnou proto svírá (v souhlasné poloze) stejný úhel $52^\circ$ jako levá strana.",
          r"Úhel, který vnitřní úsečka svírá s pravou stranou směrem k dolnímu (pravému) vrcholu, je vedlejší k úhlu $88^\circ$, tedy $180^\circ-88^\circ=92^\circ$.",
          r"V trojúhelníku tvořeném vnitřní úsečkou, částí základny a pravou stranou platí $\beta=180^\circ-52^\circ-92^\circ=36^\circ$."],
    ans=r"A) $36^\circ$",
    opts=[r"A) $36^\circ$", r"B) $38^\circ$", r"C) $40^\circ$", r"D) $48^\circ$", r"E) jiný výsledek"],
    svg=fig(6, (118, 486, 352, 574), strip_text=True), fn=FN,
    alt="Trojúhelník; z bodu na základně vede vnitřní úsečka k bodu na pravé straně. Úhel při levém dolním vrcholu je 52°, vnitřní úsečka svírá s pravou stranou (k hornímu vrcholu) úhel 88°, úhel při pravém dolním vrcholu je β. Dvě dvojité čárky vyznačují dvě shodné úsečky (část levé strany a vnitřní úsečku).", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 13", pts=2, mins=3, diff="3",
    zad=[r"Krabici tvaru kvádru lze naplnit až po okraj shodnými krychličkami s délkou hrany $2\ \mathrm{cm}$. Na dno krabice se do jedné vrstvy naskládá bez mezer $20$ krychliček a takové vrstvy mohou být v krabici nejvýše $4$. Ze zcela naplněné krabice vyjmeme všechny krychličky a vytvoříme z nich jedinou řadu (krychličky přiléhají stěnami za sebou).",
         r"Jak dlouhá bude řada?"],
    solp=[r"Krabice pojme $20\cdot4=80$ krychliček. Řada z $80$ krychliček o hraně $2\ \mathrm{cm}$ má délku $80\cdot2=160\ \mathrm{cm}=1{,}6\ \mathrm{m}$."],
    ans=r"B) $1{,}6\ \mathrm{m}$",
    opts=[r"A) $0{,}8\ \mathrm{m}$", r"B) $1{,}6\ \mathrm{m}$", r"C) $2{,}0\ \mathrm{m}$", r"D) $2{,}4\ \mathrm{m}$", r"E) delší než $2{,}4\ \mathrm{m}$"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 14", pts=2, mins=3, diff="3",
    zad=[r"Krabici tvaru kvádru lze naplnit až po okraj shodnými krychličkami s délkou hrany $2\ \mathrm{cm}$. Na dno krabice se do jedné vrstvy naskládá bez mezer $20$ krychliček a takové vrstvy mohou být v krabici nejvýše $4$.",
         r"Jaký je objem krabice?"],
    solp=[r"Krabice pojme $20\cdot4=80$ krychliček, každá má objem $2^3=8\ \mathrm{cm}^3$; objem krabice $80\cdot8=640\ \mathrm{cm}^3$."],
    ans=r"D) $640\ \mathrm{cm}^3$",
    opts=[r"A) $160\ \mathrm{cm}^3$", r"B) $320\ \mathrm{cm}^3$", r"C) $480\ \mathrm{cm}^3$", r"D) $640\ \mathrm{cm}^3$", r"E) jiný objem"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Dvě plné lahve minerálky tvoří $5\ \%$ zásob. Kolik plných lahví minerálky tvoří čtvrtinu zásob?",
         r"15.2 V autobusu jede $21$ osob. Dětí je mezi nimi o třetinu více než dospělých. Kolik dospělých jede v autobusu?",
         r"15.3 Tabulka udává počet žáků v devátých třídách: třída 9.\,A má $11$ chlapců, $14$ dívek, celkem $25$ žáků; obě deváté třídy mají dohromady $50$ žáků. Mezi všemi žáky obou devátých tříd je $54\ \%$ dívek. Kolik chlapců je ve třídě 9.\,B?",
         r"Nabídka: A) méně než $9$; B) $9$; C) $10$; D) $11$; E) $12$; F) více než $12$."],
    solp=[r"15.1: $2$ lahve $=5\ \%$, tedy $1\ \%$ odpovídá $0{,}4$ lahve; čtvrtina $=25\ \%$ odpovídá $25\cdot0{,}4=10$ lahvím — \textbf{C}.",
          r"15.2: je-li dospělých $x$, dětí je $\frac{4}{3}x$; $x+\frac{4}{3}x=\frac{7}{3}x=21\Rightarrow x=9$ dospělých — \textbf{B}.",
          r"15.3: dívek je $54\ \%$ z $50$, tj. $27$; chlapců celkem $50-27=23$; ve třídě 9.\,B je chlapců $23-11=12$ — \textbf{E}."],
    ans=r"15.1: C; 15.2: B; 15.3: E",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2017 M9B · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Dva nebo více shodných obdélníků poskládáme těsně vedle sebe do jedné řady. Pokud se každé dva sousední obdélníky dotýkají kratší stranou, vznikne obrazec typu \textbf{A}; dotýkají-li se delší stranou, vznikne obrazec typu \textbf{B}. Platí: obvody obrazců typu \textbf{A} a \textbf{B} složených ze dvou obdélníků se liší o $10\ \mathrm{cm}$. Přidáme-li k oběma obrazcům další obdélníky, rozdíl mezi obvody obou obrazců se mění.",
         r"16.1 Vypočtěte, o kolik cm se liší obvody obrazců \textbf{A} a \textbf{B}, obsahuje-li každý z nich tři obdélníky.",
         r"16.2 Vypočtěte, o kolik cm se liší obvody obrazců \textbf{A} a \textbf{B}, obsahuje-li každý z nich šest obdélníků.",
         r"16.3 Obvody obrazců \textbf{A} a \textbf{B}, které obsahují stejný počet obdélníků, se liší o $100\ \mathrm{cm}$. Vypočtěte, z kolika obdélníků je složen jeden z těchto obrazců."],
    solp=[r"Nechť má obdélník kratší stranu $a$ a delší stranu $b$. Obrazec typu \textbf{A} z $n$ obdélníků (spojených kratšími stranami) má obvod $2(nb+a)$; typu \textbf{B} (spojených delšími stranami) má obvod $2(na+b)$. Jejich rozdíl je $2(nb+a)-2(na+b)=2(n-1)(b-a)$.",
          r"Pro $n=2$ je rozdíl $2(b-a)=10\ \mathrm{cm}$, tedy $b-a=5\ \mathrm{cm}$; obecně je rozdíl $2(n-1)\cdot5=10(n-1)\ \mathrm{cm}$.",
          r"16.1: $n=3\Rightarrow10\cdot(3-1)=20\ \mathrm{cm}$.",
          r"16.2: $n=6\Rightarrow10\cdot(6-1)=50\ \mathrm{cm}$.",
          r"16.3: $10(n-1)=100\Rightarrow n-1=10\Rightarrow n=11$ obdélníků."],
    ans=r"16.1: $20\ \mathrm{cm}$; 16.2: $50\ \mathrm{cm}$; 16.3: $11$ obdélníků",
    codes=["zs2", "r9", "posloupnosti", "planimetrie", "obvod", "algebra", "vypocet", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9B-2017")
print("WROTE:")
for path, size, names in written:
    print(f"  {path}  {size} B  ({len(names)} úloh)")
