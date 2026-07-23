String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD24C0T01';
Integer YEAR = 2024;

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
  'CERMAT M5A 2024 - uloha 1.1',
  new List<String>{'Vypocitejte: $5\\cdot 115+(232+21\\cdot 8):(5+60:3)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5\\cdot 115=575$; $232+21\\cdot 8=232+168=400$; $5+60:3=5+20=25$; $400:25=16$; celkem $575+16=591$.'},
  '$591$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2024 - uloha 1.2',
  new List<String>{'Vypocitejte: $(128+16:4-32):(30+5\\cdot 13-9\\cdot 5)-1=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$128+16:4-32=128+4-32=100$; $30+5\\cdot 13-9\\cdot 5=30+65-45=50$; $100:50=2$; $2-1=1$.'},
  '$1$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2024 - uloha 2',
  new List<String>{'Najdete a napiste jednu cislici, kterou lze nahradit vsechny hvezdicky tak, aby vypocet byl spravny (viz obrazek).','Do zaznamoveho archu uvedte pouze chybejici cislici.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" font-family="monospace" font-size="26"> <text x="200" y="50" text-anchor="end">1 7 * 4</text> <text x="40" y="95" text-anchor="start">+</text> <text x="200" y="95" text-anchor="end">* 8 4 7</text> <line x1="45" y1="110" x2="200" y2="110" stroke="#000" stroke-width="2"/> <text x="200" y="150" text-anchor="end">8 * 1 1</text> </svg>',
  'scitani.svg',
  'Svisle scitani dvou ctyrciferných cisel s hvezdickami na miste chybejicich cislic.',
  'Scitani s chybejicimi cislicemi',
  new List<String>{'Hvezdicky nahradime cislici $6$: $1764+6847=8611$. Soucet i oba scitance pak souhlasi.'},
  '$6$',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2024 - uloha 3',
  new List<String>{'V souctovem trojuhelniku plati, ze soucet dvou cisel, ktera jsou v radku vedle sebe, je vzdy zapsan o radek nize do ramecku, ktery s temito obema cisly sousedi. Napriklad z cisel $1$, $2$, $3$ vznikne v dalsim radku $3$ a $5$ a nakonec $8$.','V souctovem trojuhelniku na obrazku patri do obou sedych poli stejne cislo.','Jake cislo musi byt v obou sedych polich?'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 250 160" font-family="sans-serif"> <rect x="20" y="20" width="70" height="40" fill="none" stroke="#000"/> <text x="55" y="46" font-size="18" text-anchor="middle">7</text> <rect x="90" y="20" width="70" height="40" fill="#bdbdbd" stroke="#000"/> <rect x="160" y="20" width="70" height="40" fill="#bdbdbd" stroke="#000"/> <rect x="55" y="60" width="70" height="40" fill="none" stroke="#000"/> <rect x="125" y="60" width="70" height="40" fill="none" stroke="#000"/> <rect x="90" y="100" width="70" height="40" fill="none" stroke="#000"/> <text x="125" y="126" font-size="18" text-anchor="middle">25</text> </svg>',
  'souctovy-trojuhelnik.svg',
  'Souctovy trojuhelnik: horni radek 7 a dve seda pole, prostredni radek dve prazdna pole, dole cislo 25.',
  'Souctovy trojuhelnik',
  new List<String>{'Oznacme hledane cislo $x$. V prvnim radku jsou cisla $7$, $x$, $x$. Ve druhem radku vzniknou $7+x$ a $2x$, ve tretim radku pak $(7+x)+2x=7+3x$. Plati $7+3x=25$, tedy $3x=18$ a $x=6$.'},
  '$6$',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2024 - uloha 4.1',
  new List<String>{'Zuzanka koupila darek a krabicku, do ktere ho chtela zabalit. Celkova cena za darek i krabicku byla $84$ Kc. Darek byl o $72$ Kc drazsi nez krabicka.','Kolikrat je darek drazsi nez krabicka?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Krabicka stoji $k$, darek $k+72$. Plati $k+(k+72)=84$, tedy $2k=12$ a $k=6$ Kc. Darek stoji $78$ Kc. Pomer $78:6=13$.'},
  '$13$krat',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M5A 2024 - uloha 4.2',
  new List<String>{'Lukas ma svuj ucet, na ktery mu maminka pravidelne posila kapesne a on sam si tam uklada vsechny sve nasetrene penize. K narozeninam dostal od babicky $500$ Kc. Ty pouzil na koupi knizky, ktera stala $186$ Kc, a zbyle penize si ulozil na ucet. Pote mu na ucet maminka poslala kapesne $150$ Kc a Lukas druhy den z uctu vybral $263$ Kc na darek pro tatinka. Na uctu mu pak zbylo $470$ Kc.','Kolik penez mel Lukas na uctu pred narozeninami, pokud k jinym pohybum na uctu nedoslo?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Na ucet pribylo $500-186=314$ Kc a $150$ Kc, ubylo $263$ Kc. Pred narozeninami mel $x$; $x+314+150-263=470$, tedy $x+201=470$ a $x=269$ Kc.'},
  '$269$ Kc',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
