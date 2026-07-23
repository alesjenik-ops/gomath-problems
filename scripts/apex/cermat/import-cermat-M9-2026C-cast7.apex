String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD26C0T03';
Integer YEAR = 2026;

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
  'CERMAT M9C 2026 – úloha 12',
  new List<String>{'Chlapci chtěli nahrát stejné video na internet. Jan použil připojení s rychlostí nahrávání 36 Mb za sekundu a nahrání videa mu trvalo 1 hodinu. Karel použil připojení s rychlostí nahrávání 54 Mb za sekundu. (Rychlost nahrávání videa byla v obou případech stálá a během nahrávání nedošlo k žádnému výpadku.)','Kolik minut trvalo nahrání videa Karlovi?'},
  new List<String>{'A) 40 minut','B) 45 minut','C) 60 minut','D) 90 minut','E) jiný počet minut'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Velikost videa je $36\\cdot 3600=129\\,600$ Mb (1 hodina má 3600 s). Karlovi trvalo nahrání $129\\,600:54=2400$ s $=40$ minut. (Rychlejší připojení v poměru $54:36=3:2$ zkrátí čas na $60\\cdot\\frac{2}{3}=40$ minut.)'},
  'A) 40 minut',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2026 – úloha 13',
  new List<String>{'Na tržišti se vyměňuje zboží. Jedna husa se vymění za 48 kg brambor, jedna slepice za 18 kg brambor.','Za kolik hus se vymění stejné množství brambor, jako se vymění za 40 slepic?'},
  new List<String>{'A) za 20 hus','B) za 18 hus','C) za 16 hus','D) za 15 hus','E) za 12 hus'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Za 40 slepic se vymění $40\\cdot 18=720$ kg brambor. To odpovídá $720:48=15$ husám.'},
  'D) za 15 hus',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2026 – úloha 14',
  new List<String>{'V parku se konaly běžecké závody dvoučlenných a čtyřčlenných štafet. Závodů se zúčastnilo celkem 60 soutěžících a ti vytvořili 21 štafet. Každý soutěžící běžel pouze v jedné štafetě.','Jaká část soutěžících běžela ve čtyřčlenných štafetách?'},
  new List<String>{'A) $\\frac{3}{10}$','B) $\\frac{7}{20}$','C) $\\frac{3}{5}$','D) $\\frac{2}{3}$','E) jiná část'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť je $d$ dvoučlenných a $c$ čtyřčlenných štafet: $d+c=21$ a $2d+4c=60$. Řešením je $c=9$, $d=12$. Ve čtyřčlenných štafetách běželo $4\\cdot 9=36$ soutěžících, tj. $\\frac{36}{60}=\\frac{3}{5}$ všech.'},
  'C) $\\frac{3}{5}$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2026 – úloha 15',
  new List<String>{'Každý z 80 prvňáků dostal školní sadu. Všechny tyto sady dohromady stály 36 000 korun. Školní sada pro prvňáky obsahuje slabikář a balíček na malování s temperami a pastelkami.','Přiřaďte ke každé úloze (15.1 až 15.3) odpovídající výsledek (A až F).','15.1 Každý prvňák zaplatil za školní sadu 90 korun a zbytek její ceny uhradila škola. Kolik procent z ceny sady pro prvňáky uhradila škola?','15.2 Poměr ceny temper ku ceně pastelek byl 3 : 2. O kolik procent byla cena temper vyšší než cena pastelek?','15.3 Cena slabikáře byla o 50 korun vyšší než cena balíčku na malování. O kolik procent byla cena slabikáře vyšší než cena balíčku na malování?'},
  new List<String>{'A) 20 %','B) 25 %','C) 30 %','D) 40 %','E) 50 %','F) více než 50 %'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Cena jedné sady je $36\\,000:80=450$ korun.','15.1 Škola uhradila $450-90=360$ korun, tj. $\\frac{360}{450}=0{,}8=80\\,\\%$ ceny – více než 50 %, výsledek F.','15.2 Poměr temper ku pastelkám je $3:2$; tempery jsou vyšší o $\\frac{3-2}{2}=\\frac{1}{2}=50\\,\\%$ – výsledek E.','15.3 Slabikář $+$ balíček $=450$ a slabikář je o 50 korun dražší, tedy balíček stojí 200 korun a slabikář 250 korun. Slabikář je vyšší o $\\frac{50}{200}=25\\,\\%$ – výsledek B.'},
  '15.1: F (škola uhradila 80 %); 15.2: E (o 50 %); 15.3: B (o 25 %)',
  6, 9, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
