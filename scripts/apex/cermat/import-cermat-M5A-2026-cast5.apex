String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD26C0T01';
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
  'CERMAT M5A 2026 – úloha 10',
  new List<String>{'V aquaparku získávají děti v plaveckých soutěžích žetony, za které mohou koupit volné jízdy na tobogánu nebo na člunu, avšak pouze podle dvou pravidel: za 4 žetony se kupují 3 jízdy na tobogánu, za 15 žetonů se kupují 2 jízdy na člunu. Nela za všechny své získané žetony koupila několik jízd na člunu a dvakrát tolik jízd na tobogánu.','Jaký nejmenší počet žetonů musela Nela získat?'},
  new List<String>{'A) 114 žetonů','B) 93 žetonů','C) 61 žetonů','D) 34 žetonů','E) jiný počet žetonů'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Jízdy na člunu po 2 (za 15 ž.), jízdy na tobogánu po 3 (za 4 ž.). Nechť člunových jízd $2k$, tobogánových $2\\cdot 2k=4k$. Žetony: člun $\\frac{2k}{2}\\cdot 15=15k$, tobogán $\\frac{4k}{3}\\cdot 4$. Aby vyšlo celé, $4k$ dělitelné 3 → nejmenší $k=3$: člun 6 jízd, tobogán 12 jízd; žetony $15\\cdot3 + \\frac{12}{3}\\cdot4 = 45+16=61$.'},
  'C) 61 žetonů',
  2, 5, '4',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2026 – úloha 11',
  new List<String>{'Těleso se má podle návodu slepit ze sedmi stejných malých krychliček.','Pouze jedno z těles A–E není slepeno přesně podle návodu. Které? (Tělesa A–E viz testový sešit.)'},
  new List<String>{'A) těleso A','B) těleso B','C) těleso C','D) těleso D','E) těleso E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 120" font-family="sans-serif"> <text x="280" y="70" font-size="13" text-anchor="middle">Těleso ze 7 stejných krychliček – návod a 5 variant A–E (viz testový sešit).</text> <text x="280" y="95" font-size="11" text-anchor="middle" fill="#666">Prostorová tělesa nelze věrně přenést do SVG; posuzuje se podle originálu.</text> </svg>',
  'krychle.svg',
  'Návod a pět prostorových těles A–E ze sedmi krychliček (schematická poznámka).',
  'Prostorová tělesa – viz testový sešit',
  new List<String>{'Porovnáním počtu a rozmístění krychliček s návodem neodpovídá těleso B.'},
  'B) těleso B',
  2, 3, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2026 – úloha 12',
  new List<String>{'Mirek a Janek využili pro své aktivity stejně dlouhou dobu. Mirek hrál třikrát 45 minut na počítači, čtvrt hodiny sledoval videa na mobilu a dalších 15 minut chatoval s kamarádem. Janek si četl a pak sportoval. Sportováním strávil o 15 minut delší dobu, než věnoval četbě.','Jak dlouho si Janek četl?'},
  new List<String>{'A) 75 minut','B) 85 minut','C) 90 minut','D) 105 minut','E) více než 105 minut'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Mirek: $3\\cdot 45+15+15=165$ min. Janek: četba $x$, sport $x+15$, dohromady $2x+15=165\\Rightarrow x=75$ min.'},
  'A) 75 minut',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2026 – úloha 13',
  new List<String>{'Přiřaďte ke každému hledanému číslu (13.1–13.3) odpovídající hodnotu (A–F).','13.1 Zmenšíme-li hledané číslo $K$ o jednu jeho třetinu, dostaneme číslo 18. $K=?$','13.2 Zmenšíme-li hledané číslo $L$ na čtvrtinu jeho hodnoty a od výsledku odečteme číslo 3, dostaneme číslo 4. $L=?$','13.3 Zvětšíme-li hledané číslo $M$ třikrát, dostaneme stejné číslo, jako když polovinu čísla $M$ zvětšíme o 30. $M=?$'},
  new List<String>{'A) méně než 12','B) 12','C) 15','D) 20','E) 27','F) více než 27'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'13.1 $\\frac{2}{3}K=18\\Rightarrow K=27$ → E.','13.2 $\\frac{L}{4}-3=4\\Rightarrow \\frac{L}{4}=7\\Rightarrow L=28$ (více než 27) → F.','13.3 $3M=\\frac{M}{2}+30\\Rightarrow \\frac{5M}{2}=30\\Rightarrow M=12$ → B.'},
  '13.1: E ($K=27$); 13.2: F ($L=28$); 13.3: B ($M=12$)',
  5, 6, '3',
  new List<String>{'zs1','rovnice','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
