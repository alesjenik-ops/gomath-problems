String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD18C0T02';
Integer YEAR = 2018;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M7B 2018 – úloha 11',
  new List<String>{'Na obrázku jsou dvě různoběžky a příčka; jsou vyznačeny velikosti úhlů $60^\\circ$, $70^\\circ$ a $140^\\circ$.','Jaká je velikost úhlu $\\varphi$? Úhly neměřte, ale vypočtěte.'},
  new List<String>{'A) $40^\\circ$','B) $50^\\circ$','C) $60^\\circ$','D) $70^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif"> <line x1="30" y1="255" x2="470" y2="255" stroke="#000" stroke-width="2"/> <line x1="95" y1="255" x2="300" y2="45" stroke="#000" stroke-width="2"/> <line x1="255" y1="35" x2="380" y2="295" stroke="#000" stroke-width="2"/> <line x1="60" y1="120" x2="440" y2="205" stroke="#000" stroke-width="2"/> <path d="M 130 255 A 35 35 0 0 1 150 227" fill="none" stroke="#000"/> <text x="120" y="248" font-size="15">60°</text> <path d="M 268 78 A 30 30 0 0 1 300 92" fill="none" stroke="#000"/> <text x="270" y="72" font-size="15">70°</text> <path d="M 388 175 A 45 45 0 0 1 300 168" fill="none" stroke="#000"/> <text x="330" y="168" font-size="15">140°</text> <path d="M 300 255 A 40 40 0 0 1 330 235" fill="none" stroke="#000"/> <text x="308" y="248" font-size="16" font-style="italic">&#966;</text> </svg>',
  'uhly-fi.svg',
  'Trojúhelník na přímce s vyznačenými úhly 60° u levého vrcholu, 70° nahoře, 140° u příčky a hledaným úhlem fí u pravého vrcholu.',
  'Schematický nákres k úloze 11',
  new List<String>{'V pomocném trojúhelníku, který tvoří obě různoběžky a příčka, je jeden úhel $70^\\circ$ a druhý $180^\\circ-140^\\circ=40^\\circ$, takže třetí úhel (vrcholový úhel obou různoběžek) je $180^\\circ-70^\\circ-40^\\circ=70^\\circ$. Ve velkém trojúhelníku pak platí $60^\\circ+70^\\circ+\\varphi=180^\\circ$, odtud $\\varphi=50^\\circ$.'},
  'B) $50^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2018 – úloha 12',
  new List<String>{'V pondělí znečištěná plocha pokrývala šestnáctinu plochy hladiny rybníka. V každém z dalších dnů byla velikost znečištěné plochy na hladině rybníka vždy dvakrát větší než o den dříve.','Ve kterém dnu v týdnu znečištěná plocha pokryla polovinu plochy hladiny rybníka?'},
  new List<String>{'A) ve čtvrtek','B) v pátek','C) v sobotu','D) v neděli','E) v jiném dnu'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Pondělí $\\frac{1}{16}$, úterý $\\frac{2}{16}$, středa $\\frac{4}{16}$, čtvrtek $\\frac{8}{16}=\\frac{1}{2}$. Polovinu tedy plocha pokryla ve čtvrtek.'},
  'A) ve čtvrtek',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2018 – úloha 13',
  new List<String>{'Sedmé třídy (7. A a 7. B) uspořádaly sběr papíru. Každý žák přinesl stejné množství papíru. V jednotlivých třídách je počet žáků větší než 20 a menší než 30. V 7. A nasbírali žáci celkem 580 kg papíru, přičemž chlapci nasbírali o 100 kg méně než dívky. V 7. B je celkem 24 dětí a mezi nimi je dvakrát více chlapců než dívek.','Kolik kg papíru nasbíraly dívky 7. A?'},
  new List<String>{'A) $300$ kg','B) $320$ kg','C) $340$ kg','D) $360$ kg','E) jiný počet kg'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Dívky $d$, chlapci $d-100$; $d+(d-100)=580$, tedy $2d=680$ a $d=340$. Dívky 7. A nasbíraly $340$ kg.'},
  'C) $340$ kg',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2018 – úloha 14',
  new List<String>{'Vyjděte z výchozího textu a tabulky k úlohám 13–14 (sběr papíru tříd 7. A a 7. B; každý žák přinesl stejné množství papíru, počet žáků ve třídě je větší než 20 a menší než 30).','Kolik kg papíru nasbírali chlapci 7. B?'},
  new List<String>{'A) $300$ kg','B) $320$ kg','C) $340$ kg','D) $360$ kg','E) jiný počet kg'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'V 7. A je $17$ dívek a $12$ chlapců, tj. $29$ žáků; na jednoho připadá $580:29=20$ kg. V 7. B je z 24 dětí $8$ dívek a $16$ chlapců. Chlapci 7. B nasbírali $16\\cdot 20=320$ kg.'},
  'B) $320$ kg',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
