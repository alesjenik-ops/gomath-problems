String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD24C0T02';
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
  'CERMAT M7B 2024 - uloha 15',
  new List<String>{'Ke kazde poduloze (15.1-15.3) priradte spravny vysledek z nabidky (A-F).','15.1 $22.$ unora letosniho roku prislo do zlatnictvi $36$ lidi, coz je $80\\,\\%$ zakazniku, kteri prisli ve stejny den minuleho roku. Kolik lidi navstivilo zlatnictvi $22.$ unora vloni?','15.2 Penal stal puvodne $60$ Kc, po Vanocich byl zlevnen o $30\\,\\%$ z ceny. Jaka je nova cena penalu v korunach?','15.3 Puvodne stal televizor $18\\,000$ Kc, jeho nova cena je $9\\,720$ Kc. O kolik procent byl televizor zlevnen?'},
  new List<String>{'A) $42$','B) $43$','C) $44$','D) $45$','E) $46$','F) $47$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 $36$ je $80\\,\\%$, tj. $36:0{,}8 = 45$ lidi - moznost D.','15.2 Sleva $30\\,\\%$: nova cena $60\\cdot 0{,}7 = 42$ Kc - moznost A.','15.3 $9\\,720:18\\,000 = 0{,}54$, cena klesla na $54\\,\\%$, sleva je $46\\,\\%$ - moznost E.'},
  '15.1: D ($45$); 15.2: A ($42$ Kc); 15.3: E ($46\\,\\%$)',
  6, 6, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M7B 2024 - uloha 16',
  new List<String>{'Do chodby dlouhe $5{,}6$ m a siroke $3{,}2$ m bude tatinek pokladat dlazbu. Pouzivat bude jednobarevne a dvoubarevne ctvercove dlazdice o strane $20$ cm. Sestavovat je bude do motivu na obrazku, ktery se bude pravidelne opakovat.','16.1 Kolik kusu jednobarevnych dlazdic bude tatinek potrebovat na vydlazdeni cele chodby?','16.2 Kolik metru ctverecnich dvoubarevnych dlazdic bude tatinek potrebovat na vydlazdeni cele chodby? Vysledek uvedte s presnosti na dve desetinna mista.','16.3 Nejmensi baleni, po kterem se jednobarevne dlazdice prodavaji, je $1$ m2; cena za $1$ m2 je $240$ Kc. Kolik korun zaplati tatinek za jednobarevne dlazdice?','16.4 Dvoubarevne dlazdice se prodavaji pouze v baleni po $20$ kusech; cena za baleni je $360$ Kc. Kolik korun zaplati tatinek za dvoubarevne dlazdice?'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 180 180" font-family="sans-serif"><polygon points="10,10 50,10 10,50" fill="#8a8a8a"/><polygon points="130,10 170,10 170,50" fill="#8a8a8a"/><polygon points="10,130 10,170 50,170" fill="#8a8a8a"/><polygon points="170,130 170,170 130,170" fill="#8a8a8a"/><polygon points="90,50 130,90 90,130 50,90" fill="#8a8a8a"/><line x1="10" y1="10" x2="10" y2="170" stroke="#000"/><line x1="10" y1="10" x2="170" y2="10" stroke="#000"/><line x1="50" y1="10" x2="50" y2="170" stroke="#000"/><line x1="10" y1="50" x2="170" y2="50" stroke="#000"/><line x1="90" y1="10" x2="90" y2="170" stroke="#000"/><line x1="10" y1="90" x2="170" y2="90" stroke="#000"/><line x1="130" y1="10" x2="130" y2="170" stroke="#000"/><line x1="10" y1="130" x2="170" y2="130" stroke="#000"/><line x1="170" y1="10" x2="170" y2="170" stroke="#000"/><line x1="10" y1="170" x2="170" y2="170" stroke="#000"/></svg>',
  'dlazba-motiv.svg',
  'Opakujici se ctvercovy motiv dlazby 4 krat 4 s rohovymi trojuhelniky a stredovym kosoctvercem.',
  'Motiv dlazby (schematicky nakres)',
  new List<String>{'Chodba ma rozmery $28\\times 16 = 448$ dlazdic (strana dlazdice $0{,}2$ m). V opakujicim se motivu $4\\times 4$ je polovina dlazdic jednobarevnych a polovina dvoubarevnych, takze obou druhu je po $448:2 = 224$ kusech.','16.1 Jednobarevnych dlazdic je $224$ kusu.','16.2 Dvoubarevnych je $224$ kusu, tj. $224\\cdot 0{,}2\\cdot 0{,}2 = 8{,}96$ m2.','16.3 Jednobarevne ($8{,}96$ m2) se prodavaji po celych $1$ m2, nutno koupit $9$ m2: $9\\cdot 240 = 2\\,160$ Kc.','16.4 Dvoubarevnych $224$ kusu, baleni po $20$: nutno koupit $12$ baleni: $12\\cdot 360 = 4\\,320$ Kc.'},
  '16.1: $224$ kusu; 16.2: $8{,}96$ m2; 16.3: $2\\,160$ Kc; 16.4: $4\\,320$ Kc',
  4, 9, '4',
  new List<String>{'zs2','r7','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
