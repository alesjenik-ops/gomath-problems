# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9A 2025 (1. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9A_2025_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2025, 1. řádný termín (M9A)"
CCODE = "M9PAD25C0T01"
YR = 2025
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2025 M9A · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte, kolikrát je součet čísel $16$ a $4$ větší než druhá odmocnina ze součinu čísel $16$ a $4$."],
    solp=[r"Součet: $16+4=20$. Odmocnina ze součinu: $\sqrt{16\cdot4}=\sqrt{64}=8$.",
          r"$20:8=2{,}5$."],
    ans=r"$2{,}5$krát",
    codes=["zs2", "r9", "aritmetika", "mocniny-odmocniny", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 2", pts=3, mins=5, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"2.1 \quad $(-3)\cdot\left(\dfrac{3}{4}-\dfrac{5}{6}\right)=$",
         r"2.2 \quad $\dfrac{\dfrac{\sqrt{25}}{\sqrt{2\cdot2}}}{\dfrac{3\cdot(3^2-2\cdot2)}{\sqrt{5^2-4^2}}}=$"],
    solp=[r"2.1: $(-3)\cdot\left(\frac{9}{12}-\frac{10}{12}\right)=(-3)\cdot\left(-\frac{1}{12}\right)=\frac{1}{4}$.",
          r"2.2: čitatel $\frac{\sqrt{25}}{\sqrt{4}}=\frac{5}{2}$; jmenovatel $\frac{3\cdot(9-4)}{\sqrt{9}}=\frac{15}{3}=5$; celkem $\frac{5}{2}:5=\frac{1}{2}$."],
    ans=r"2.1: $\frac{1}{4}$; 2.2: $\frac{1}{2}$",
    codes=["zs2", "r9", "zlomky", "mocniny-odmocniny", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"3.1 Do rámečků doplňte taková čísla, aby platila rovnost: $(a+\square)^2=a^2+18a+\square$.",
         r"3.2 Upravte na co nejjednodušší tvar bez závorek: $2-(n+2)\cdot(-n)+(3-n)\cdot(n+1)=$",
         r"3.3 Upravte a výsledný výraz rozložte na součin pomocí vzorce: $x\cdot(18-x)+9\cdot(16-2x)=$"],
    solp=[r"3.1: $(a+9)^2=a^2+18a+81$, do rámečků $9$ a $81$.",
          r"3.2: $2+(n^2+2n)+(3n+3-n^2-n)=4n+5$.",
          r"3.3: $18x-x^2+144-18x=144-x^2=(12-x)(12+x)$."],
    ans=r"3.1: $9$ a $81$; 3.2: $4n+5$; 3.3: $(12-x)(12+x)$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 4", pts=4, mins=6, diff="4",
    zad=[r"Řešte rovnici:",
         r"4.1 \quad $7\cdot\left(\dfrac{4}{7}-\dfrac{x}{10}\right)-5\cdot\left(\dfrac{x}{25}-\dfrac{16}{5}\right)=\dfrac{1}{10}x$",
         r"4.2 \quad $y-(y+5)\cdot0{,}1=0{,}9y+0{,}5$"],
    solp=[r"4.1: $4-\frac{7x}{10}-\frac{x}{5}+16=\frac{x}{10}\Rightarrow 20-\frac{9x}{10}=\frac{x}{10}\Rightarrow 20=x\Rightarrow x=20$.",
          r"4.2: $y-0{,}1y-0{,}5=0{,}9y+0{,}5\Rightarrow 0{,}9y-0{,}5=0{,}9y+0{,}5\Rightarrow -0{,}5=0{,}5$; rovnice nemá řešení."],
    ans=r"4.1: $x=20$; 4.2: rovnice nemá řešení",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Na obrázku je plánek pozemku tvaru čtverce s délkou strany $c=30\ \mathrm{m}$. Světle šedý obdélník je půdorys domu, tmavší obrazec je rybníček. Půdorys domu má pětkrát menší obsah, než je celková rozloha pozemku.",
         r"5.1 Délka domu $a$ je rovna polovině délky strany pozemku $c$. Určete šířku domu $b$.",
         r"5.2 Rozloha rybníčku je $18\ \%$ celkové rozlohy pozemku. Vypočtěte v $\mathrm{m}^2$ rozlohu volné části pozemku, na níž není ani dům, ani rybníček."],
    solp=[r"Rozloha pozemku $30^2=900\ \mathrm{m}^2$; půdorys domu $\frac{900}{5}=180\ \mathrm{m}^2$.",
          r"5.1: $a=\frac{c}{2}=15\ \mathrm{m}$, tedy $b=\frac{180}{15}=12\ \mathrm{m}$.",
          r"5.2: rybníček $0{,}18\cdot900=162\ \mathrm{m}^2$; volná část $900-180-162=558\ \mathrm{m}^2$."],
    ans=r"5.1: $b=12\ \mathrm{m}$; 5.2: $558\ \mathrm{m}^2$",
    svg=fig(3, (338, 58, 595, 215)), fn=FN,
    alt="Plánek čtvercového pozemku o straně 30 m se světle šedým obdélníkovým půdorysem domu (délka a, šířka b) a tmavším rybníčkem.",
    cap="",
    codes=["zs2", "r9", "procenta", "geometrie", "slovni", "modelovani", "s-kalkulackou", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 6", pts=2, mins=4, diff="3",
    zad=[r"Zahradní sud má tvar rotačního válce. Dno sudu má obsah $1\,500\ \mathrm{cm}^2$.",
         r"6.1 Při dešti stoupla hladina vody v sudu o $10\ \mathrm{mm}$. Vypočtěte, kolik litrů vody přibylo v sudu.",
         r"6.2 Při silném lijáku přibyly v sudu $3$ litry vody. Vypočtěte, o kolik mm stoupla hladina vody."],
    solp=[r"6.1: $10\ \mathrm{mm}=1\ \mathrm{cm}$; objem $1\,500\cdot1=1\,500\ \mathrm{cm}^3=1{,}5$ litru.",
          r"6.2: $3$ litry $=3\,000\ \mathrm{cm}^3$; výška $\frac{3\,000}{1\,500}=2\ \mathrm{cm}=20\ \mathrm{mm}$."],
    ans=r"6.1: $1{,}5$ litru; 6.2: $20\ \mathrm{mm}$",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 7", pts=3, mins=5, diff="3",
    zad=[r"V rovině leží přímky $p$, $q$, $r$, které se protínají v bodě $R$, a přímky $s$, $t$, pro které platí $s\parallel r$, $s\perp t$ (viz obrázek). Jsou vyznačeny úhly $30^\circ$ a $130^\circ$.",
         r"Vypočtěte ve stupních velikost úhlu (velikosti neměřte, ale vypočtěte):",
         r"7.1 $\alpha$, \quad 7.2 $\beta$, \quad 7.3 $\gamma$."],
    solp=[r"7.1: $\alpha=30^\circ$ (vrcholové, resp. souhlasné úhly).",
          r"7.2: $\beta=180^\circ-130^\circ-... =50^\circ$ (dopočet z přímého úhlu a daných úhlů).",
          r"7.3: $\gamma=140^\circ$ (vrcholový k úhlu $180^\circ-40^\circ$, resp. dopočet z $s\parallel r$)."],
    ans=r"7.1: $\alpha=30^\circ$; 7.2: $\beta=50^\circ$; 7.3: $\gamma=140^\circ$",
    svg=fig(4, (300, 420, 595, 645)), fn=FN,
    alt="Přímky p, q, r protínající se v bodě R a přímky s (rovnoběžná s r) a t (kolmá na s); vyznačené úhly 30° a 130° a hledané úhly alfa, beta, gama.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 8", pts=4, mins=6, diff="4",
    zad=[r"Záhon má tvar čtyřúhelníku, jehož tři strany jsou stejně dlouhé a každá z nich je o čtvrtinu kratší než čtvrtá (nejdelší) strana. Po obvodu je ve stejných rozestupech $40\ \mathrm{cm}$ vysázeno celkem $65$ rostlin, po jedné i v každém rohu.",
         r"8.1 Vypočtěte v metrech obvod záhonu.",
         r"8.2 Určete, o kolik se liší počet rostlin na nejdelší straně od počtu rostlin na protější straně.",
         r"8.3 Po obvodu se pravidelně střídají stejně početné skupinky červeně kvetoucích rostlin s dvojicemi bíle kvetoucích. Určete nejmenší možný počet červeně kvetoucích rostlin."],
    solp=[r"8.1: rozestupů je po obvodu $65$; obvod $65\cdot0{,}4=26\ \mathrm{m}$.",
          r"8.2: kratší strana $=\frac{3}{4}$ nejdelší; $3\cdot\frac{3}{4}L+L=\frac{13}{4}L=26\Rightarrow L=8\ \mathrm{m}$, kratší $6\ \mathrm{m}$. Rostlin na $8\ \mathrm{m}$ straně $21$, na $6\ \mathrm{m}$ straně $16$; rozdíl $5$.",
          r"8.3: skupinka $r$ červených $+$ dvojice bílých, $n$ skupin: $n(r+2)=65$; nejméně červených pro $r+2=5$, tj. $n=13$, $r=3$: $13\cdot3=39$."],
    ans=r"8.1: $26$ metrů; 8.2: o $5$ rostlin; 8.3: $39$ červeně kvetoucích rostlin",
    svg=fig(5, (75, 122, 500, 245)), fn=FN,
    alt="Čtyřúhelníkový záhon se třemi stejně dlouhými stranami a jednou nejdelší; podél obvodu rostliny v rozestupech 40 cm.",
    cap="",
    codes=["zs2", "r9", "aritmetika", "geometrie", "argumentace", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží různoběžky $p$, $q$ a bod $R$ (viz obrázek).",
         r"9.1 Sestrojte osu většího úhlu, který svírají přímky $p$, $q$, a označte ji písmenem $o$.",
         r"9.2 Na přímkách $p$, $q$ leží všechny čtyři vrcholy obdélníku $KLMN$; bod $R$ leží uvnitř strany $MN$. Sestrojte vrcholy obdélníku $KLMN$, označte je a obdélník narýsujte."],
    solp=[r"9.1: osu $o$ většího úhlu sestrojíme jako osu úhlu dvou různoběžek (množina bodů stejně vzdálených od $p$ i $q$).",
          r"9.2: obdélník $KLMN$ vepsaný do úhlu je souměrný podle osy $o$; strana $MN$ je kolmá k $o$ a prochází bodem $R$. Z bodu $R$ vedeme kolmici k $o$ (strana $MN$), její průsečíky s $p$, $q$ jsou $M$, $N$; osovou souměrností podle $o$, resp. kolmicemi, dostaneme $K$, $L$."],
    ans=r"Osa $o$ většího úhlu; obdélník $KLMN$ souměrný podle $o$ se stranou $MN\perp o$ procházející bodem $R$ (viz konstrukce).",
    svg=fig(6, (62, 64, 595, 360)), fn=FN,
    alt="Různoběžky p, q a bod R v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 10", pts=2, mins=5, diff="4",
    zad=[r"V rovině leží bod $B$ a přímky $p$, $q$, které se protínají v bodě $C$ (viz obrázek).",
         r"Body $B$, $C$ jsou vrcholy trojúhelníku $ABC$. Na přímce $p$ leží výška $v_c$ na stranu $c$ a na přímce $q$ leží těžnice $t_c$ na stranu $c$. Sestrojte vrchol $A$ trojúhelníku $ABC$, označte ho a trojúhelník narýsujte."],
    solp=[r"Výška $v_c$ i těžnice $t_c$ vycházejí z vrcholu $C$; obě leží na daných přímkách procházejících $C$.",
          r"Strana $c=AB$ je kolmá k výšce $v_c$ (přímka $p$). Střed strany $AB$ leží na těžnici $t_c$ (přímka $q$).",
          r"Sestrojíme přímku $AB$ kolmou k $p$ procházející $B$; její průsečík s $q$ je střed strany $c$, a vrchol $A$ je obraz $B$ v tomto středu."],
    ans=r"Strana $AB\perp p$ prochází bodem $B$; střed $AB$ je průsečík této přímky s $q$; vrchol $A$ je obraz $B$ podle tohoto středu.",
    svg=fig(7, (62, 64, 595, 360)), fn=FN,
    alt="Bod B a přímky p, q protínající se v bodě C.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 11", pts=4, mins=5, diff="3",
    zad=[r"Základní kvádr má délky hran $1\ \mathrm{cm}$, $2\ \mathrm{cm}$ a $3\ \mathrm{cm}$. Každé z těles bylo slepeno ze dvou základních kvádrů; čtyřboké hranoly jsou $M$, $N$ a další tělesa $P$, $Q$, $R$ (viz obrázek).",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"11.1 Součet délek všech hran jednoho základního kvádru je $24\ \mathrm{cm}$.",
         r"11.2 Povrchy hranolů $M$ a $N$ se liší o $6\ \mathrm{cm}^2$.",
         r"11.3 Všechna tři tělesa $P$, $Q$, $R$ mají stejný povrch."],
    solp=[r"11.1: součet hran kvádru $4\cdot(1+2+3)=24\ \mathrm{cm}$ — A.",
          r"11.2: povrchy hranolů $M$ a $N$ (slepené různými stěnami) se liší o $6\ \mathrm{cm}^2$ — A.",
          r"11.3: tělesa $P$, $Q$, $R$ mají stejný povrch — A."],
    ans=r"11.1: A; 11.2: A; 11.3: A",
    svg=fig(8, (66, 96, 595, 182)), fn=FN,
    alt="Základní kvádr 1×2×3 cm a tělesa M, N, P, Q, R slepená vždy ze dvou základních kvádrů.",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 12", pts=2, mins=4, diff="3",
    zad=[r"Bazén má délku $40\ \mathrm{m}$ a šířku $10\ \mathrm{m}$. V celé zóně pro neplavce (délka $20\ \mathrm{m}$) je hloubka $1\ \mathrm{m}$. Zóna pro plavce (délka $20\ \mathrm{m}$) má šikmé dno a hloubka se zvětšuje z $1\ \mathrm{m}$ na $2\ \mathrm{m}$ (viz obrázek).",
         r"Jaký je objem bazénu?"],
    opts=[r"A) $500\ \mathrm{m}^3$", r"B) $550\ \mathrm{m}^3$", r"C) $600\ \mathrm{m}^3$", r"D) $650\ \mathrm{m}^3$", r"E) jiný objem"],
    solp=[r"Zóna pro neplavce: $20\cdot10\cdot1=200\ \mathrm{m}^3$.",
          r"Zóna pro plavce (průměrná hloubka $1{,}5\ \mathrm{m}$): $20\cdot10\cdot1{,}5=300\ \mathrm{m}^3$.",
          r"Celkem $200+300=500\ \mathrm{m}^3$."],
    ans=r"A) $500\ \mathrm{m}^3$",
    svg=fig(8, (78, 392, 500, 485)), fn=FN,
    alt="Podélný řez bazénu délky 40 m: zóna pro neplavce hloubka 1 m a zóna pro plavce se šikmým dnem od 1 m do 2 m.",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 13", pts=2, mins=4, diff="3",
    zad=[r"Tábory se pořádaly ve dvou termínech se stejným počtem nabízených míst. Sešlo se celkem $375$ přihlášek. V prvním termínu počet přihlášek překročil počet míst o pětinu, ve druhém termínu o $30\ \%$.",
         r"Kolik přihlášek celkem muselo být kvůli nedostatku míst odmítnuto?"],
    opts=[r"A) $65$ přihlášek", r"B) $75$ přihlášek", r"C) $80$ přihlášek", r"D) $85$ přihlášek", r"E) jiný počet přihlášek"],
    solp=[r"Nechť je $m$ míst v každém termínu: $1{,}2m+1{,}3m=2{,}5m=375\Rightarrow m=150$.",
          r"Odmítnuto: $0{,}2m+0{,}3m=0{,}5m=75$ přihlášek."],
    ans=r"B) $75$ přihlášek",
    codes=["zs2", "r9", "procenta", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 14", pts=2, mins=4, diff="3",
    zad=[r"Test z matematiky psalo $20$ žáků. Nejhorší známka byla $3$ (známky $4$ a $5$ nikdo nedostal). Počet jedniček a dvojek byl stejný. Aritmetický průměr známek byl $1{,}8$.",
         r"Kolik žáků dostalo z testu známku $1$?"],
    opts=[r"A) $5$ žáků", r"B) $6$ žáků", r"C) $7$ žáků", r"D) $8$ žáků", r"E) $9$ žáků"],
    solp=[r"Nechť je $k$ jedniček i dvojek, pak trojek je $20-2k$.",
          r"$\frac{1\cdot k+2\cdot k+3\cdot(20-2k)}{20}=1{,}8\Rightarrow 60-3k=36\Rightarrow k=8$."],
    ans=r"D) $8$ žáků",
    codes=["zs2", "r9", "statistika", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 15", pts=6, mins=6, diff="4",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Nastoupilo $10$ družstev po $11$ hráčích a všichni organizátoři, dohromady $200$ osob. Kolik procent osob tvořili organizátoři?",
         r"15.2 Soutěže se účastnilo $20$ tříčlenných družstev, v každém aspoň jeden muž a aspoň jedna žena. Družstev s jedním mužem bylo čtyřikrát více než družstev s jednou ženou. Kolik procent soutěžících tvořily ženy?",
         r"15.3 Každý atlet soutěžil v jedné ze tří disciplín. V hodu oštěpem $12$ atletů. Skokanů bylo o $40\ \%$ méně než běžců, ale o $50\ \%$ více než oštěpařů. Kolik procent soutěžících tvořili běžci?"],
    opts=[r"A) $40\ \%$", r"B) $45\ \%$", r"C) $50\ \%$", r"D) $55\ \%$", r"E) $60\ \%$", r"F) více než $60\ \%$"],
    solp=[r"15.1: hráčů $10\cdot11=110$, organizátorů $200-110=90$; $\frac{90}{200}=45\ \%$ — B.",
          r"15.2: družstev s $1$ ženou (tj. $2$M$1$Ž) je $x$, s $1$ mužem (tj. $1$M$2$Ž) $4x$; $5x=20\Rightarrow x=4$. Žen $4\cdot1+16\cdot2=36$ z $60$, tj. $60\ \%$ — E.",
          r"15.3: skokanů $1{,}5\cdot12=18$; $18=0{,}6\cdot$běžců $\Rightarrow$ běžců $30$; celkem $30+18+12=60$; běžci $\frac{30}{60}=50\ \%$ — C."],
    ans=r"15.1: B ($45\ \%$); 15.2: E ($60\ \%$); 15.3: C ($50\ \%$)",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "s-kalkulackou", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9A · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Vytváříme tmavé a světlé obrazce tvaru čtverce: bílý čtverec obklopený pásem shodných obdélníčků $2\ \mathrm{cm}\times3\ \mathrm{cm}$. U tmavých obrazců je pás užší, u světlých širší. Obrazec popisujeme třemi čísly: počet obdélníčků, délka strany bílého čtverce, délka strany celého obrazce (např. tmavé $4,1,5$ a $8,4,8$; světlý $8,1,7$).",
         r"16.1 Délka strany tmavého obrazce je $20\ \mathrm{cm}$. Určete počet obdélníčků.",
         r"16.2 Délka strany tmavého i světlého obrazce je $23\ \mathrm{cm}$. Určete, o kolik se liší počet obdélníčků v těchto dvou obrazcích.",
         r"16.3 Tmavý i světlý obrazec mají stejný počet obdélníčků, ale délky stran bílých čtverců se liší o $10\ \mathrm{cm}$. Určete počet obdélníčků v tmavém obrazci."],
    solp=[r"Počet obdélníčků $=\frac{(\text{strana obrazce})^2-(\text{strana bílého čtverce})^2}{6}$. U tmavého je strana obrazce o $4$ větší než bílý čtverec, u světlého o $6$.",
          r"16.1: bílý $20-4=16$; počet $\frac{20^2-16^2}{6}=\frac{144}{6}=24$.",
          r"16.2: tmavý bílý $19$, počet $\frac{23^2-19^2}{6}=28$; světlý bílý $17$, počet $\frac{23^2-17^2}{6}=40$; rozdíl $12$.",
          r"16.3: tmavý bílý $b_t$, světlý $b_s$, $b_t-b_s=10$ a stejný počet dává $b_t=25$; počet $\frac{29^2-25^2}{6}=36$."],
    ans=r"16.1: $24$ obdélníčků; 16.2: o $12$ obdélníčků; 16.3: $36$ obdélníčků",
    svg=fig(11, (66, 104, 500, 200)), fn=FN,
    alt="Tmavé a světlé čtvercové obrazce: bílý čtverec obklopený pásem obdélníčků 2×3 cm, tmavý pás užší, světlý širší.",
    cap="",
    codes=["zs2", "r9", "posloupnosti", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9A-2025")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
