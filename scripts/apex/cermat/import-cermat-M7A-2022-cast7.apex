String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD22C0T01';
Integer YEAR = 2022;

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
  'CERMAT M7A 2022 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Kniha se původně prodávala za $300$ korun. Po zlevnění stojí jen $40\\,\\%$ původní ceny. O kolik korun byla kniha zlevněna?','15.2 Původní cena knihy byla snížena o $120$ korun. Po tomto zlevnění se tak prodávala za $25\\,\\%$ původní ceny. Jaká byla původní cena knihy?','15.3 Kniha byla zlevněna dvakrát. Na léto byla zlevněna o $50$ korun, tj. o $20\\,\\%$ původní ceny. Na podzim pak byla zlevněna ještě o čtvrtinu letní ceny. Kolik korun stála kniha po obou slevách?'},
  new List<String>{'A) méně než $120$ korun','B) $120$ korun','C) $150$ korun','D) $160$ korun','E) $180$ korun','F) více než $180$ korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Po zlevnění stojí $40\\,\\%$ ze $300=120$ korun; zlevněna byla o $300-120=180$ korun → E.','15.2 Původní cena $x$: $x-120=0{,}25x$, tj. $0{,}75x=120$, $x=160$ korun → D.','15.3 $50$ korun je $20\\,\\%$ původní ceny, tedy původní cena $250$ korun; letní cena $250-50=200$ korun; podzimní cena $200-\\frac{1}{4}\\cdot 200=150$ korun → C.'},
  '15.1: E ($180$ korun); 15.2: D ($160$ korun); 15.3: C ($150$ korun)',
  6, 8, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M7A 2022 – úloha 16',
  new List<String>{'Pyramida se skládá ze shodných čtverců. Horní řadu tvoří vždy jeden tmavý čtverec. V pyramidě, která má více než $1$ čtverec, se pravidelně střídají řady s tmavými a řady s bílými čtverci. Každá další řada má vždy o $1$ čtverec více než řada nad ní (viz obrázek).','16.1 Pyramida má $10$ řad. Určete, o kolik se liší počet tmavých a bílých čtverců v pyramidě.','16.2 Pyramida má $73$ řad. Určete, o kolik se liší počet tmavých a bílých čtverců v pyramidě.','16.3 V pyramidě je o $101$ bílých čtverců méně než tmavých čtverců. Určete, kolik řad má pyramida.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 190" font-family="sans-serif"><rect x="50" y="145" width="20" height="20" fill="#9a9a9a" stroke="#000"/><rect x="120" y="125" width="20" height="20" fill="#9a9a9a" stroke="#000"/><rect x="110" y="145" width="20" height="20" fill="#ffffff" stroke="#000"/><rect x="130" y="145" width="20" height="20" fill="#ffffff" stroke="#000"/><rect x="205" y="105" width="20" height="20" fill="#9a9a9a" stroke="#000"/><rect x="195" y="125" width="20" height="20" fill="#ffffff" stroke="#000"/><rect x="215" y="125" width="20" height="20" fill="#ffffff" stroke="#000"/><rect x="185" y="145" width="20" height="20" fill="#9a9a9a" stroke="#000"/><rect x="205" y="145" width="20" height="20" fill="#9a9a9a" stroke="#000"/><rect x="225" y="145" width="20" height="20" fill="#9a9a9a" stroke="#000"/><rect x="305" y="85" width="20" height="20" fill="#9a9a9a" stroke="#000"/><rect x="295" y="105" width="20" height="20" fill="#ffffff" stroke="#000"/><rect x="315" y="105" width="20" height="20" fill="#ffffff" stroke="#000"/><rect x="285" y="125" width="20" height="20" fill="#9a9a9a" stroke="#000"/><rect x="305" y="125" width="20" height="20" fill="#9a9a9a" stroke="#000"/><rect x="325" y="125" width="20" height="20" fill="#9a9a9a" stroke="#000"/><rect x="275" y="145" width="20" height="20" fill="#ffffff" stroke="#000"/><rect x="295" y="145" width="20" height="20" fill="#ffffff" stroke="#000"/><rect x="315" y="145" width="20" height="20" fill="#ffffff" stroke="#000"/><rect x="335" y="145" width="20" height="20" fill="#ffffff" stroke="#000"/><text x="375" y="150" font-size="26">…</text></svg>',
  'pyramida.svg',
  'Pyramidy z 1, 2, 3 a 4 řad se střídajícími se tmavými a bílými řadami čtverců.',
  'Pyramidy z 1, 2, 3 a 4 řad',
  new List<String>{'Řada $k$ má $k$ čtverců; liché řady jsou tmavé, sudé bílé.','16.1 Tmavé (řady 1,3,5,7,9): $1+3+5+7+9=25$; bílé (2,4,6,8,10): $2+4+6+8+10=30$. Liší se o $30-25=5$ čtverce.','16.2 Tmavé $1+3+\\dots+73=37^2=1369$; bílé $2+4+\\dots+72=36\\cdot 37=1332$. Liší se o $1369-1332=37$ čtverců.','16.3 Pro lichý počet řad $2m+1$ je tmavých o $m+1$ více než bílých: $m+1=101$, $m=100$, tedy $2m+1=201$ řad.'},
  '16.1: o $5$ čtverců; 16.2: o $37$ čtverců; 16.3: $201$ řad',
  4, 8, '3',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
