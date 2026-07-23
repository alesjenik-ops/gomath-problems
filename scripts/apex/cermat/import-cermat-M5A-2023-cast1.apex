String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD23C0T01';
Integer YEAR = 2023;

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
  'CERMAT M5A 2023 – úloha 1.1',
  new List<String>{'Vypočtěte: $5\\cdot 120+(700-6\\cdot 25):(10-7+2)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5\\cdot 120+(700-150):(10-7+2)=600+550:5=600+110=710$.'},
  '$710$',
  2, 2, '1',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2023 – úloha 1.2',
  new List<String>{'Vypočtěte: $(5+5\\cdot 29)-4\\cdot(176:8-8\\cdot 2)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(5+145)-4\\cdot(22-16)=150-4\\cdot 6=150-24=126$.'},
  '$126$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2023 – úloha 2.1',
  new List<String>{'Vypočtěte, o kolik litrů se liší čtvrtina z 24 litrů a třetina z 12 litrů.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čtvrtina z $24$ litrů je $24:4=6$ litrů, třetina z $12$ litrů je $12:3=4$ litry. Liší se o $6-4=2$ litry.'},
  'o $2$ litry',
  2, 2, '1',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2023 – úloha 2.2',
  new List<String>{'Vynásobením dvou kladných celých čísel jsme získali součin 180. Jedno z těchto dvou čísel zvětšíme dvakrát a jedno zmenšíme šestkrát.','Určete, jaký součin získáme vynásobením obou změněných čísel.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Součin se násobí dvěma a dělí šesti, tedy vydělí třemi: nový součin je $180\\cdot 2:6=180:3=60$.'},
  '$60$',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2023 – úloha 3',
  new List<String>{'V rotě je jeden kapitán a má pod sebou 4 poručíky. Každý poručík má pod sebou 3 své četaře a každý četař má pod sebou 10 svých vojínů. (Další osoby v rotě nejsou.) Kapitán se rozhodl svolat celou rotu k nástupu. Rozkaz k nástupu se předával tak, že kapitán vydal rozkaz všem poručíkům, z nichž každý vydal tento rozkaz svým četařům a každý četař jej vydal svým vojínům. Poté celá rota nastoupila.','3.1 Vypočtěte, kolik je v rotě vojínů.','3.2 Vypočtěte, kolik osob v rotě vydalo rozkaz k nástupu.','3.3 Vypočtěte, kolik osob v rotě dostalo rozkaz k nástupu.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Poručíků je $4$, četařů $4\\cdot 3=12$, vojínů $12\\cdot 10=120$.','3.1 V rotě je $120$ vojínů.','3.2 Rozkaz vydal kapitán, všichni poručíci a všichni četaři: $1+4+12=17$ osob.','3.3 Rozkaz dostali všichni poručíci, četaři a vojíni: $4+12+120=136$ osob.'},
  '3.1: $120$ vojínů; 3.2: $17$ osob; 3.3: $136$ osob',
  3, 4, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2023 – úloha 4',
  new List<String>{'Jana koupila v papírnictví několik stejných linkovaných sešitů, několik stejných čtverečkovaných sešitů a několik stejných kružítek.','4.1 Jana koupila celkem 36 sešitů, přičemž linkovaných koupila třikrát více než čtverečkovaných. Vypočtěte, kolik linkovaných sešitů koupila.','4.2 Dva linkované sešity a dva čtverečkované sešity stojí dohromady 180 korun. Dva čtverečkované sešity stojí stejně jako tři linkované. Vypočtěte, kolik korun stojí jeden čtverečkovaný sešit.','4.3 K nákupu šesti kružítek chybělo Janě 160 korun, proto koupila jen čtyři kružítka a zbylo jí 100 korun. Vypočtěte, kolik korun zaplatila za 4 kružítka.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Čtverečkovaných je $x$, linkovaných $3x$; celkem $x+3x=4x=36$, tedy $x=9$ a linkovaných $3\\cdot 9=27$.','4.2 Linkovaný stojí $l$, čtverečkovaný $c$: z $2l+2c=180$ je $l+c=90$, a $2c=3l$. Dosadíme $c=\\tfrac{3}{2}l$: $\\tfrac{5}{2}l=90$, $l=36$, $c=54$. Jeden čtverečkovaný stojí $54$ korun.','4.3 Cena kružítka $k$: $6k$ převyšuje peníze o $160$ a $4k$ je o $100$ menší, takže $6k-4k=160+100$, $2k=260$, $k=130$. Za $4$ kružítka $4\\cdot 130=520$ korun.'},
  '4.1: $27$ linkovaných sešitů; 4.2: $54$ korun; 4.3: $520$ korun',
  5, 7, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
