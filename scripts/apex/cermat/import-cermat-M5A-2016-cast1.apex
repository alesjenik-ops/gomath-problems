String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M5A 2016 – úloha 1',
  new List<String>{'Vypočtěte: $80-15\\cdot 5-5:5=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Nejprve násobení a dělení: $15\\cdot 5=75$, $5:5=1$.','Potom zleva doprava: $80-75-1=4$.'},
  '$4$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2016 – úloha 2',
  new List<String>{'Vypočtěte, kolikrát je třeba k číslu $750$ přičíst číslo $10$, abychom získali číslo $7\\,500$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Musíme přidat $7\\,500-750=6\\,750$.','Přičítáme po deseti: $6\\,750:10=675$.'},
  '$675$krát',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2016 – úloha 3.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$(60-24):4=(60-24:4):\\square$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Levá strana: $(60-24):4=36:4=9$.','Pravá strana: $(60-24:4)=(60-6)=54$, tedy $54:\\square=9$.','Odtud $\\square=54:9=6$.'},
  '$6$',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2016 – úloha 3.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$10+12\\cdot 3=10+(12\\cdot 3)+\\square$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Levá strana: $10+36=46$.','Pravá strana: $10+36+\\square=46+\\square$.','Obě strany se rovnají, tedy $\\square=0$.'},
  '$0$',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2016 – úloha 4',
  new List<String>{'Nahraďte každou hvězdičku ($*$) takovou číslicí, aby byl součin co nejmenší. Zapište celý výpočet (oba činitele i součin).','Čtyřciferné číslo $*\\,*\\,*\\,*$ násobíme dvěma a dostaneme pěticiferný součin ve tvaru $1\\,*\\,*\\,5\\,2$.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Součin má tvar $1\\,*\\,*\\,5\\,2$, nejmenší možný takový součin je $10\\,052$.','Ověření: $10\\,052:2=5\\,026$ je čtyřciferné číslo, tedy zápis vychází.','Výpočet: $5\\,026\\cdot 2=10\\,052$.'},
  '$5\\,026\\cdot 2=10\\,052$',
  3, 4, '4',
  new List<String>{'zs1','aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2016 – úloha 5',
  new List<String>{'Na talíři bylo 12 koláčů. Dan z nich snědl třetinu. Eva snědla stejný počet koláčů jako Dan, ale vzala si je z mísy. Počet koláčů na míse se tak zmenšil o pětinu.','5.1 Vypočtěte, kolik koláčů zbylo na talíři.','5.2 Vypočtěte, kolik koláčů bylo v míse, než je Eva začala jíst.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Dan snědl $12:3=4$ koláče, na talíři zbylo $12-4=8$ koláčů.','5.2 Eva snědla také $4$ koláče a to byla pětina obsahu mísy, tedy v míse bylo $4\\cdot 5=20$ koláčů.'},
  '5.1: $8$ koláčů; 5.2: $20$ koláčů',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2016 – úloha 6',
  new List<String>{'Na trase Bor–Raná jezdí proti sobě dva vlaky. Při každé cestě oba vlaky vyjíždějí ve stejnou dobu a potkávají se pravidelně v polovině doby jízdy.','Hodiny nyní ukazují 18:05 a naposledy se oba vlaky potkaly před čtvrt hodinou. Vlak do Rané přijede v 18:10.','6.1 Zapište, v kolik hodin se oba vlaky naposledy potkaly.','6.2 Vypočtěte, jak dlouho trvá cesta vlakem z Boru do Rané.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Čtvrt hodiny je $15$ minut, tedy $18{:}05-15$ minut $=17{:}50$.','6.2 Od setkání v $17{:}50$ do příjezdu v $18{:}10$ uplyne $20$ minut, což je druhá polovina jízdy.','Celá cesta tedy trvá $2\\cdot 20=40$ minut.'},
  '6.1: v 17:50; 6.2: $40$ minut',
  3, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
