# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9C 2025 (1. náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9C_2025_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2025, 1. náhradní termín (M9C)"
CCODE = "M9PCD25C0T03"
YR = 2025
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2025 M9C · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Určete, kolikrát více je $5$ kilogramů než $0{,}25$ gramů."],
    solp=[r"$5\ \mathrm{kg}=5\,000\ \mathrm{g}$; $5\,000:0{,}25=20\,000$."],
    ans=r"$20\,000$krát",
    codes=["zs2", "r9", "aritmetika", "desetinna-cisla", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 2", pts=1, mins=3, diff="3",
    zad=[r"Druhá mocnina neznámého prvočísla je o $3$ menší než jiné prvočíslo. Určete větší z obou prvočísel."],
    solp=[r"Hledáme prvočíslo $p$ tak, aby $p^2+3$ bylo také prvočíslo. Pro $p=2$: $2^2+3=7$ je prvočíslo.",
          r"Větší z prvočísel je $7$."],
    ans=r"$7$",
    codes=["zs2", "r9", "aritmetika", "argumentace", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 3", pts=3, mins=5, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{\sqrt{10^2-19}}{\sqrt{10^2}}=$",
         r"3.2 \quad $\dfrac{\left(\dfrac{3}{5}\right)^2}{\dfrac{27}{34}\cdot\left(\dfrac{2}{3}-\dfrac{3^2}{5}\right)}=$"],
    solp=[r"3.1: $\frac{\sqrt{81}}{\sqrt{100}}=\frac{9}{10}$.",
          r"3.2: čitatel $\frac{9}{25}$; jmenovatel $\frac{27}{34}\cdot\left(\frac{2}{3}-\frac{9}{5}\right)=\frac{27}{34}\cdot\left(-\frac{17}{15}\right)=-\frac{9}{10}$; $\frac{9}{25}:\left(-\frac{9}{10}\right)=-\frac{2}{5}$."],
    ans=r"3.1: $\frac{9}{10}$; 3.2: $-\frac{2}{5}$",
    codes=["zs2", "r9", "zlomky", "mocniny-odmocniny", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 4", pts=4, mins=5, diff="3",
    zad=[r"4.1 Upravte a umocněte (výsledný výraz nesmí obsahovat závorky): $(4+8a-8)^2=$",
         r"4.2 Upravte na co nejjednodušší tvar bez závorek: $(2-3x)\cdot2+(2x)^2-x\cdot(-6)=$",
         r"4.3 Upravte na co nejjednodušší tvar bez závorek: $(1-2n)\cdot(1-2n+4n)-2n\cdot(1-3n)+(3n-1)=$"],
    solp=[r"4.1: $(8a-4)^2=64a^2-64a+16$.",
          r"4.2: $4-6x+4x^2+6x=4x^2+4$.",
          r"4.3: $(1-2n)(1+2n)-2n+6n^2+3n-1=(1-4n^2)+6n^2+n-1=2n^2+n$."],
    ans=r"4.1: $64a^2-64a+16$; 4.2: $4x^2+4$; 4.3: $2n^2+n$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $5x+\dfrac{2}{15}+\dfrac{1}{15}x=\dfrac{2}{3}x-\dfrac{3}{5}$",
         r"5.2 \quad $4-\dfrac{7-3y}{5}=3+\dfrac{7y-4}{10}$"],
    solp=[r"5.1: vynásobením $15$: $75x+2+x=10x-9\Rightarrow 76x+2=10x-9\Rightarrow 66x=-11\Rightarrow x=-\frac{1}{6}$.",
          r"5.2: vynásobením $10$: $40-2(7-3y)=30+(7y-4)\Rightarrow 26+6y=26+7y\Rightarrow y=0$."],
    ans=r"5.1: $x=-\frac{1}{6}$; 5.2: $y=0$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 6", pts=4, mins=6, diff="3",
    zad=[r"Do ložnice jsme přikoupili postel, noční stolek a skříň. Noční stolek byl o polovinu levnější než skříň, ale o třetinu dražší než postel. Cenu nočního stolku označíme $n$.",
         r"6.1 Vyjádřete výrazem s proměnnou $n$ cenu skříně.",
         r"6.2 Vyjádřete výrazem s proměnnou $n$ cenu postele.",
         r"6.3 Za všechny tři kusy nábytku jsme zaplatili $9\,000$ korun. Vypočtěte, kolik korun stál noční stolek."],
    solp=[r"6.1: stolek je o polovinu levnější než skříň, tedy skříň $=2n$.",
          r"6.2: stolek je o třetinu dražší než postel, tedy $n=\frac{4}{3}\cdot$postel, postel $=\frac{3}{4}n$.",
          r"6.3: $n+2n+\frac{3}{4}n=\frac{15}{4}n=9\,000\Rightarrow n=2\,400$ korun."],
    ans=r"6.1: $2n$; 6.2: $\frac{3}{4}n$; 6.3: $2\,400$ korun",
    codes=["zs2", "r9", "vyrazy", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 7", pts=4, mins=6, diff="4",
    zad=[r"Cyklista jel část trasy po rovině, část klesal a zbytek stoupal. Po rovině ujel třetinu délky trasy rychlostí $30\ \mathrm{km/h}$. Klesání bylo pětkrát kratší než celá trasa, rychlost při něm o $40\ \%$ vyšší než po rovině. Stoupání bylo na $14\ \mathrm{km}$ trasy, rychlost o polovinu nižší než při klesání.",
         r"7.1 Vypočtěte v $\mathrm{km/h}$ průměrnou rychlost při klesání.",
         r"7.2 Vypočtěte v km délku celé trasy.",
         r"7.3 Vypočtěte v minutách, jak dlouho cyklista stoupal."],
    solp=[r"7.1: $30\cdot1{,}4=42\ \mathrm{km/h}$.",
          r"7.2: délka $L$: $\frac{L}{3}+\frac{L}{5}+14=L\Rightarrow \frac{7}{15}L=14\Rightarrow L=30\ \mathrm{km}$.",
          r"7.3: rychlost při stoupání $\frac{42}{2}=21\ \mathrm{km/h}$; čas $\frac{14}{21}\ \mathrm{h}=\frac{2}{3}\ \mathrm{h}=40$ minut."],
    ans=r"7.1: $42\ \mathrm{km/h}$; 7.2: $30\ \mathrm{km}$; 7.3: $40$ minut",
    codes=["zs2", "r9", "aritmetika", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 8", pts=3, mins=5, diff="3",
    zad=[r"Podlaha chodby je vydlážděna čtvercovými dlaždicemi se stranou $20\ \mathrm{cm}$; každá je ozdobena čtvrtkruhem a malým kruhem (viz obrázek vlevo). Dlaždice se pokládaly ve čtveřicích (obrázek vpravo). Poloměr malého kruhu je $10\ \mathrm{cm}$... resp. dle obrázku.",
         r"8.1 Vypočtěte v $\mathrm{cm}^2$ obsah jednoho malého kruhu (zaokrouhlete na celé $\mathrm{cm}^2$).",
         r"8.2 Podlaha má tvar obdélníku $2\ \mathrm{m}\times3{,}2\ \mathrm{m}$. Určete, o kolik se liší počet malých a velkých kruhů na podlaze."],
    solp=[r"8.1: malý kruh má poloměr $5\ \mathrm{cm}$; $S=\pi\cdot5^2\doteq79\ \mathrm{cm}^2$.",
          r"8.2: dlaždic je $\frac{200}{20}\cdot\frac{320}{20}=10\cdot16=160$. Malých kruhů $160$ (po jednom na dlaždici), velké kruhy vzniknou vždy ze čtyř čtvrtkruhů čtveřice, tj. $\frac{160}{4}=40$. Rozdíl $160-40=120$."],
    ans=r"8.1: $79\ \mathrm{cm}^2$; 8.2: o $120$",
    svg=fig(4, (75, 135, 440, 250)), fn=FN,
    alt="Čtvercová dlaždice se čtvrtkruhem a malým kruhem a čtveřice dlaždic tvořící uprostřed velký kruh.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $B$, $M$ a přímka $q$ (viz obrázek).",
         r"Bod $B$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Úsečka $BM$ je jednou z výšek trojúhelníku a bod $M$ leží na straně $AC$. Na přímce $q$ leží vrchol $A$.",
         r"Sestrojte vrcholy $A$, $C$ trojúhelníku $ABC$, označte je a trojúhelník narýsujte."],
    solp=[r"$BM$ je výška na stranu $AC$, tedy $BM\perp AC$; přímka $AC$ prochází bodem $M$ kolmo k $BM$.",
          r"Vrchol $A$ je průsečík této přímky $AC$ s přímkou $q$.",
          r"Trojúhelník je rovnoramenný se základnou $AB$ (ramena $CA=CB$), takže $C$ leží na ose úsečky $AB$ i na přímce $AM$."],
    ans=r"Přímka $AC\perp BM$ prochází bodem $M$; $A=AC\cap q$; vrchol $C$ leží na přímce $AM$ a na ose úsečky $AB$.",
    svg=fig(5, (62, 64, 595, 360)), fn=FN,
    alt="Body B, M a přímka q v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $A$, $S$ a přímka $p$ (viz obrázek).",
         r"Bod $A$ je vrchol obdélníku $ABCD$, jehož vrchol $D$ leží na přímce $p$. Bod $S$ je střed strany $CD$.",
         r"Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je a obdélník narýsujte. Najděte všechna řešení."],
    solp=[r"$S$ je střed strany $CD$; strana $AD$ je kolmá k $CD$. Vrchol $D$ leží na přímce $p$.",
          r"Protože $AD\perp DC$ a $S$ je střed $CD$, dopočítáme $D$ jako patu kolmice a $C$ jako obraz $D$ podle $S$; vrchol $B$ doplníme rovnoběžníkem.",
          r"Podle polohy vzniknou dvě řešení."],
    ans=r"Vrchol $D$ na přímce $p$ s $AD\perp DC$; $C$ je obraz $D$ podle středu $S$; $B$ dopočteme jako obdélník (dvě řešení).",
    svg=fig(6, (62, 64, 595, 360)), fn=FN,
    alt="Body A, S a přímka p v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 11", pts=4, mins=5, diff="3",
    zad=[r"Rodný dům je otevřen od května do září. V grafu je návštěvnost (děti a dospělí) v jedné sezoně.",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"11.1 V prvních třech měsících sezony bylo mezi návštěvníky třikrát více dospělých než dětí.",
         r"11.2 Za celou sezonu bylo dospělých návštěvníků průměrně $80$ za měsíc.",
         r"11.3 Za celou sezonu tvořily děti $40\ \%$ všech návštěvníků."],
    solp=[r"Z grafu děti: $30,10,30,50,40$; dospělí: $80,60,70,90,100$.",
          r"11.1: prvních tři měsíce děti $70$, dospělí $210=3\cdot70$ — A.",
          r"11.2: dospělých celkem $400$, průměr $\frac{400}{5}=80$ — A.",
          r"11.3: dětí $160$ z celkových $560$, tj. asi $28{,}6\ \%$, nikoli $40\ \%$ — N."],
    ans=r"11.1: A; 11.2: A; 11.3: N",
    svg=fig(7, (80, 120, 370, 305)), fn=FN,
    alt="Sloupcový graf počtu prodaných vstupenek dětem a dospělým v měsících květen až září.",
    cap="",
    codes=["zs2", "r9", "statistika", "procenta", "porozumeni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Na hřišti je uzavřený okruh z $5$ rovných úseků, některé sousední úseky jsou na sebe kolmé (viz obrázek). Jirka prošel okruh stejně dlouhými kroky; do plánku zaznamenal počty kroků na prvních čtyřech úsecích ($30$, $35$, $50$, $100$).",
         r"Kolika kroky prošel Jirka poslední úsek okruhu?"],
    opts=[r"A) méně než $85$ kroky", r"B) $85$ kroky", r"C) $90$ kroky", r"D) $95$ kroky", r"E) $100$ kroky"],
    solp=[r"Okruh je uzavřený; z vyznačených kolmostí a Pythagorovy věty (úsek délky $100$ kroků je přeponou pravoúhlého trojúhelníku s odvěsnami danými zbývajícími úseky) vychází poslední úsek $95$ kroků."],
    ans=r"D) $95$ kroky",
    svg=fig(8, (335, 68, 560, 185)), fn=FN,
    alt="Plánek uzavřeného okruhu z pěti rovných úseků s vyznačenými kolmostmi a délkami 30, 35, 50, 100 kroků a neznámým posledním úsekem.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Na každé stěně krychle je úhlopříčka přelepena pěti shodnými šedými čtverci tak, že sousední čtverce mají právě jeden společný vrchol (viz obrázek). Nepolepená část každé stěny je bílá. Součet obsahů všech bílých ploch na povrchu krychle je $480\ \mathrm{cm}^2$.",
         r"Jakou délku má hrana krychle?"],
    opts=[r"A) méně než $10\ \mathrm{cm}$", r"B) $10\ \mathrm{cm}$", r"C) $12\ \mathrm{cm}$", r"D) $15\ \mathrm{cm}$", r"E) $20\ \mathrm{cm}$"],
    solp=[r"Pět čtverců o straně $s$ podél úhlopříčky stěny (spojených vrcholy) dává úhlopříčku stěny $5s\sqrt{2}$, tedy hrana $a=5s$.",
          r"Šedá plocha stěny $5s^2$, bílá $a^2-5s^2=25s^2-5s^2=20s^2$. Za $6$ stěn $120s^2=480\Rightarrow s=2$, tedy $a=5\cdot2=10\ \mathrm{cm}$."],
    ans=r"B) $10\ \mathrm{cm}$",
    svg=fig(8, (335, 296, 560, 425)), fn=FN,
    alt="Krychle, na každé stěně je úhlopříčka přelepena pěti šedými čtverci spojenými vrcholy.",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 14", pts=2, mins=4, diff="4",
    zad=[r"V obdélníku $ABCD$ leží na straně $CD$ bod $X$. Přímka $o_1$ je osa úhlu $BAX$ a přímka $o_2$ je osa úhlu $AXB$. V obrázku jsou vyznačeny úhly $22^\circ$ a $62^\circ$.",
         r"Jaká je velikost úhlu $\alpha$? (Velikosti neměřte, ale vypočtěte.)"],
    opts=[r"A) $22^\circ$", r"B) $28^\circ$", r"C) $34^\circ$", r"D) $40^\circ$", r"E) jiná velikost"],
    solp=[r"Z os úhlů $BAX$ a $AXB$ a z pravých úhlů obdélníku (a rovnoběžnosti $AB$ s $CD$) se dopočtou vnitřní úhly; vychází $\alpha=34^\circ$."],
    ans=r"C) $34^\circ$",
    svg=fig(9, (75, 66, 470, 180)), fn=FN,
    alt="Obdélník ABCD s bodem X na straně CD, osami o1 úhlu BAX a o2 úhlu AXB a vyznačenými úhly 22° a 62°.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 15", pts=6, mins=6, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Kbelík se naplní $50$ hrnky borůvek. Z plného kbelíku jsme odsypali $46\ \%$ borůvek. Kolik hrnků zbývá v kbelíku?",
         r"15.2 Petr, Radim, Slávek a Tomáš vyrobili dohromady $240$ hrnků. Petr vyrobil o polovinu méně než Radim, Slávek i Tomáš každý o $25\ \%$ méně než Radim. O kolik hrnků více vyrobil Tomáš než Petr?",
         r"15.3 Maminka natrhala dvakrát více rybízu než Jitka, babička o polovinu více než Jitka; babička natrhala o $2$ hrnky méně než maminka. Kolik hrnků natrhaly všechny tři dohromady?"],
    opts=[r"A) $18$ hrnků", r"B) $20$ hrnků", r"C) $21$ hrnků", r"D) $23$ hrnků", r"E) $25$ hrnků", r"F) více než $25$ hrnků"],
    solp=[r"15.1: zbývá $54\ \%$ z $50$, tj. $27$ hrnků — F.",
          r"15.2: $\frac{R}{2}+R+\frac{3}{4}R+\frac{3}{4}R=3R=240\Rightarrow R=80$; Tomáš $60$, Petr $40$, rozdíl $20$ — B.",
          r"15.3: maminka $2J$, babička $1{,}5J$; $2J-1{,}5J=2\Rightarrow J=4$; celkem $4{,}5\cdot4=18$ — A."],
    ans=r"15.1: F ($27$); 15.2: B ($20$); 15.3: A ($18$)",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9C · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Vytváříme obrazce tvaru pravidelného šestiúhelníku složené z bílých a šedých shodných rovnostranných trojúhelníků. První obrazec má $3$ bílé a $3$ šedé trojúhelníky; každý další vznikne přidáním jednoho pásu trojúhelníků okolo předchozího (viz obrázek).",
         r"16.1 Vypočtěte, kolik trojúhelníků (bílých i šedých) obsahuje poslední přidaný pás $4.$ obrazce.",
         r"16.2 Vypočtěte, kolik šedých trojúhelníků obsahuje celý $6.$ obrazec.",
         r"16.3 Určete, kolikátý obrazec má v posledním přidaném pásu $225$ šedých trojúhelníků."],
    solp=[r"$n$-tý obrazec má celkem $6n^2$ trojúhelníků, z toho $3n^2$ šedých. Poslední pás má $6n^2-6(n-1)^2=12n-6$ trojúhelníků, z toho $6n-3$ šedých.",
          r"16.1: $12\cdot4-6=42$ trojúhelníků.",
          r"16.2: $3\cdot6^2=108$ šedých trojúhelníků.",
          r"16.3: $6n-3=225\Rightarrow n=38$, tedy $38.$ obrazec."],
    ans=r"16.1: $42$ trojúhelníků; 16.2: $108$ šedých trojúhelníků; 16.3: $38.$ obrazec",
    svg=fig(11, (72, 140, 410, 255)), fn=FN,
    alt="Posloupnost obrazců tvaru pravidelného šestiúhelníku z bílých a šedých rovnostranných trojúhelníků (1. až 3. obrazec).",
    cap="",
    codes=["zs2", "r9", "posloupnosti", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9C-2025")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
