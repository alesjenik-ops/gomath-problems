String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD25C0T04';
Integer YEAR = 2025;

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
  'CERMAT M5D 2025 - uloha 7.2 (konstrukce)',
  new List<String>{'V rovine lezi bod $A$ a primka $p$ prochazejici bodem $R$ (viz obrazek).','Bod $A$ je vrchol ctverce $ABCD$. Na primce $p$ lezi vrchol $B$ tohoto ctverce. Bod $R$ ma od obou vrcholu $A$ i $B$ stejnou vzdalenost. Bod $R$ nelezi uvnitr ctverce $ABCD$.','Sestrojte vrcholy $B$, $C$, $D$ ctverce $ABCD$, oznacte je pismeny a ctverec narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 240" font-family="sans-serif"> <rect x="10" y="10" width="440" height="220" fill="none" stroke="#cccccc"/> <line x1="40" y1="196" x2="420" y2="150" stroke="#000" stroke-width="2"/> <text x="426" y="150" font-size="15" font-style="italic">p</text> <line x1="250" y1="164" x2="250" y2="178" stroke="#000" stroke-width="1"/> <text x="244" y="196" font-size="15" font-style="italic">R</text> <text x="228" y="118" font-size="15" font-style="italic">A</text> <text x="226" y="132" font-size="15">x</text> </svg>',
  'bod-A-primka-p.svg',
  'Bod A a primka p prochazejici vyznacenym bodem R.',
  'Vychozi obrazek k uloze 7.2',
  new List<String>{'Bod $R$ ma od $A$ i $B$ stejnou vzdalenost, lezi tedy na ose usecky $AB$. Protoze $R$ i vrchol $B$ lezi na primce $p$ a plati $|RB|=|RA|$, najdeme vrchol $B$ na primce $p$ ve vzdalenosti $|RA|$ od bodu $R$ (dve polohy $B_1$, $B_2$). Nad usečkou $AB$ sestrojime ctverec $ABCD$ tak, aby bod $R$ nelezel uvnitr. Uloha ma dve reseni.'},
  'Dve reseni: vrchol $B$ na primce $p$ ve vzdalenosti $|RA|$ od $R$ (polohy $B_1$, $B_2$), ctverec $ABCD$ doplneny na opacnou stranu nez bod $R$ - viz obrazek v klici.',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2025 - uloha 8',
  new List<String>{'Honza mel $22$ sirek o delce $4$ cm a $18$ sirek o delce $5$ cm. Ze vsech techto sirek poskladal obrazce tvaru ctverce a obrazce tvaru obdelniku. Stranu obrazce tvorila vzdy jedina sirka a zadne dva obrazce nemely spolecnou stranu.','Rozhodnete o kazdem z nasledujicich tvrzeni 8.1-8.3, zda je pravdive (A), ci nikoli (N).','8.1 Honza mohl vytvorit nejvyse $9$ ctvercu.','8.2 Honza mohl vytvorit stejny pocet ctvercu a obdelniku.','8.3 Honza mohl vytvorit obrazce tak, ze prave jeden z nich byl ctverec a vsechny ostatni byly obdelniky.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'8.1 Ctverec tvori $4$ stejne sirky. Ze $22$ ctyrcentimetrovych lze slozit nejvyse $5$ ctvercu, z $18$ peticentimetrovych nejvyse $4$ ctverce, celkem nejvyse $9$. Pravda (A).','8.2 Obdelnik (nectvercovy) tvori $2$ ctyrcentimetrove a $2$ peticentimetrove sirky. Volba $3$ ctvercu ze $4$cm, $2$ ctvercu z $5$cm a $5$ obdelniku dava $5$ ctvercu a $5$ obdelniku a spotrebuje $12+10=22$ ctyrcentimetrovych a $8+10=18$ peticentimetrovych sirek. Pravda (A).','8.3 Jeden ctverec ze $4$ ctyrcentimetrovych sirek a $9$ obdelniku (kazdy $2$ ctyrcentimetrove a $2$ peticentimetrove) spotrebuje $4+18=22$ ctyrcentimetrovych a $18$ peticentimetrovych sirek. Pravda (A).'},
  '8.1: Ano; 8.2: Ano; 8.3: Ano',
  4, 7, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2025 - uloha 9',
  new List<String>{'V obchode prodavaji ve $2$ ruznych sadach figurky dvou druhu dinosauru, T-rex a Velociraptor. Velka sada stoji $180$ korun a obsahuje $8$ figurek druhu T-rex a $5$ figurek druhu Velociraptor. Mala sada stoji $54$ korun a obsahuje $2$ figurky druhu T-rex a $2$ figurky druhu Velociraptor. Standa koupil $2$ velke sady a nekolik malych sad. Celkem tak ziskal $70$ novych figurek dinosauru.','Kolik korun utratil Standa za nakup figurek dinosauru?'},
  new List<String>{'A) $900$ korun','B) $954$ korun','C) $988$ korun','D) $1008$ korun','E) jinou castku'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Velka sada ma $8+5=13$ figurek, dve velke sady tedy $26$ figurek. Zbyva $70-26=44$ figurek z malych sad po $4$ figurkach, tj. $11$ malych sad. Cena $2\\cdot 180+11\\cdot 54=360+594=954$ korun.'},
  'B) $954$ korun',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2025 - uloha 10',
  new List<String>{'Ve stanici Licha Lhota stoji na kazde ze tri koleji jeden vlak. Vlak na druhe koleji ma o $3$ vagony vice nez vlak na prvni koleji a dvakrat mene vagonu nez vlak na treti koleji. Vsechny tri vlaky dohromady maji $41$ vagonu.','O kolik vagonu vice ma vlak na treti koleji nez vlak na prvni koleji?'},
  new List<String>{'A) o $8$ vagonu','B) o $10$ vagonu','C) o $11$ vagonu','D) o $13$ vagonu','E) o $14$ vagonu'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Pocet vagonu na prvni koleji oznacime $x$. Druha kolej $x+3$, treti kolej $2(x+3)$. Soucet $x+(x+3)+2(x+3)=4x+9=41$, tedy $x=8$. Vlaky maji $8$, $11$ a $22$ vagonu; treti ma o $22-8=14$ vagonu vice.'},
  'E) o $14$ vagonu',
  2, 3, '2',
  new List<String>{'zs1','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
