String SRC   = 'CERMAT – Ilustrační test 2019, matematika 9 (čtyřleté obory)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2019 M9I · úloha 12',
  new List<String>{'Přímky $a$, $b$, $c$ se protínají v jednom bodě, přímka $d$ tímto bodem neprochází. Přímka $a$ je vodorovná. Nad přímkou $a$ svírá levá část přímky $a$ s přímkou $b$ úhel $\\alpha$, přímka $b$ s přímkou $c$ úhel $15^\\circ$ a přímka $c$ s pravou částí přímky $a$ úhel $2\\alpha$.','Přímka $d$ protíná přímku $a$ tak, že s ní svírá úhel $\\alpha$. Úhel $\\beta$ je úhel, který spolu svírají přímky $b$ a $d$ v jejich průsečíku pod přímkou $a$.','Jaká je velikost úhlu $\\beta$? Úhly neměřte, ale vypočtěte.'},
  new List<String>{'A) $55^\\circ$','B) $60^\\circ$','C) $65^\\circ$','D) $70^\\circ$','E) jiná velikost'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Úhly nad přímkou $a$ v jejich společném bodě dávají $\\alpha+15^\\circ+2\\alpha=180^\\circ\\Rightarrow 3\\alpha=165^\\circ\\Rightarrow \\alpha=55^\\circ$.','Uvažme trojúhelník ohraničený přímkami $a$, $b$, $d$. Úhel u průsečíku $a$ a $d$ je $\\alpha=55^\\circ$. Úhel u společného bodu přímek $a$, $b$ (mezi pravou částí $a$ a přímkou $b$) je vrcholový k úhlu $\\alpha$, tedy rovněž $55^\\circ$.','Proto $\\beta=180^\\circ-55^\\circ-55^\\circ=70^\\circ$.'},
  'D) $70^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','uvazovani','bez-kalkulacky'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 13',
  new List<String>{'Uvnitř papírového kvádru je ukryto několik dřevěných krychliček s hranou délky $3{,}9\\ \\mathrm{cm}$. Síť tohoto kvádru je zakreslena ve čtvercové síti se stranou čtverce $2\\ \\mathrm{cm}$; kvádr má rozměry $6\\ \\mathrm{cm}$, $8\\ \\mathrm{cm}$ a $4\\ \\mathrm{cm}$.','Jaký je největší možný počet dřevěných krychliček, které mohou být ukryty uvnitř papírového kvádru?'},
  new List<String>{'A) méně než $3$','B) $3$','C) $4$','D) $6$','E) jiný počet'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Podél hrany $6\\ \\mathrm{cm}$ se vejde $\\lfloor 6:3{,}9\\rfloor=1$ krychlička, podél hrany $8\\ \\mathrm{cm}$ $\\lfloor 8:3{,}9\\rfloor=2$ krychličky a podél hrany $4\\ \\mathrm{cm}$ $\\lfloor 4:3{,}9\\rfloor=1$ krychlička.','Celkem se vejde nejvýše $1\\cdot 2\\cdot 1=2$ krychličky, což je méně než $3$.'},
  'A) méně než $3$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','vyber','bez-kalkulacky'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 14',
  new List<String>{'Graf udává počet prodaných zájezdů v jednotlivých měsících: leden $120$, únor $60$, březen $120$, duben $60$, květen $40$, červen $20$, červenec $10$.','Ve kterém měsíci bylo prodáno o polovinu zájezdů méně než o měsíc dříve a současně o polovinu zájezdů více než o měsíc později?'},
  new List<String>{'A) v únoru','B) v březnu','C) v dubnu','D) v květnu','E) v červnu'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Hledáme měsíc, jehož hodnota je polovinou hodnoty předchozího měsíce a zároveň je o polovinu větší než hodnota následujícího měsíce.','Duben: $60=\\frac{120}{2}$ (o polovinu méně než březen) a zároveň $60=1{,}5\\cdot 40$, tj. o polovinu více než květen ($40$). Podmínku splňuje duben.'},
  'C) v dubnu',
  2, 3, '3',
  new List<String>{'zs2','r9','grafy','aritmetika','uvazovani','vyber','bez-kalkulacky','bezny-zivot'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 \\quad Firma očekávala, že získá $120$ zakázek, ale nakonec se jí podařilo získat $180$ zakázek. O kolik procent firma překročila své očekávání?','15.2 \\quad V katalogu je cena výrobku $1\\,000\\ \\mathrm{K\\check{c}}$, ale v prodejně je o $20\\ \\%$ nižší. Na internetu se výrobek prodává za $480\\ \\mathrm{K\\check{c}}$. O kolik procent je cena výrobku na internetu nižší než v prodejně?','15.3 \\quad Spolek seniorů má tři zájmové kluby – šachy, turistiku a vaření; každý člen navštěvuje právě jeden klub. Šachy navštěvuje $15$ členů, turistiku $60\\ \\%$ všech členů a vaření $45$ členů. Ve spolku je celkem $84$ žen. Kolik procent všech členů spolku tvoří muži?','Nabídka: A) (o) méně než $40\\ \\%$; B) (o) $40\\ \\%$; C) (o) $44\\ \\%$; D) (o) $45\\ \\%$; E) (o) $50\\ \\%$; F) (o) více než $50\\ \\%$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $\\frac{180-120}{120}=\\frac{60}{120}=50\\ \\%$ — \\textbf{E}.','15.2: cena v prodejně $=1\\,000\\cdot 0{,}8=800\\ \\mathrm{K\\check{c}}$; $\\frac{800-480}{800}=\\frac{320}{800}=40\\ \\%$ — \\textbf{B}.','15.3: šachy a vaření mají $15+45=60$ členů, což je $40\\ \\%$ všech (turistika tvoří $60\\ \\%$); celkem $\\frac{60}{0{,}4}=150$ členů. Mužů je $150-84=66$; $\\frac{66}{150}=44\\ \\%$ — \\textbf{C}.'},
  '15.1: E; 15.2: B; 15.3: C',
  6, 9, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PID19C0T01', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
