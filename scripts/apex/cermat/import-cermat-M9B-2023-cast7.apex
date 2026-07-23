String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD23C0T02';
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
  'CERMAT M9B 2023 – úloha 16',
  new List<String>{'Vybarvováním některých prázdných polí čtvercové sítě postupně vytváříme obrazce (viz obrázek). Prvním obrazcem je jedno světle vybarvené pole čtvercové sítě. Každý další obrazec vytvoříme z předchozího tak, že vybarvíme všechna prázdná pole, která mají s předchozím obrazcem společné pouze vrcholy. Tato nově vybarvená pole jsou u sudých obrazců tmavá a u lichých obrazců světlá. Druhý obrazec jsme vytvořili z prvního vybarvením 4 dalších polí tmavou barvou. Třetí obrazec má celkem 13 polí (9 světlých a 4 tmavá).','16.1 Určete, vybarvením kolika dalších polí jsme z 8. obrazce vytvořili 9. obrazec.','16.2 Určete, o kolik se liší počet tmavých a světlých polí v 10. obrazci.','16.3 Určete, kolik světlých polí může mít obrazec, který má 400 tmavých polí. Najděte všechna řešení.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 160" font-family="sans-serif"><g stroke="#ccc" stroke-width="0.8"><line x1="10" y1="15" x2="10" y2="111"/><line x1="10" y1="15" x2="106" y2="15"/><line x1="26" y1="15" x2="26" y2="111"/><line x1="10" y1="31" x2="106" y2="31"/><line x1="42" y1="15" x2="42" y2="111"/><line x1="10" y1="47" x2="106" y2="47"/><line x1="58" y1="15" x2="58" y2="111"/><line x1="10" y1="63" x2="106" y2="63"/><line x1="74" y1="15" x2="74" y2="111"/><line x1="10" y1="79" x2="106" y2="79"/><line x1="90" y1="15" x2="90" y2="111"/><line x1="10" y1="95" x2="106" y2="95"/><line x1="106" y1="15" x2="106" y2="111"/><line x1="10" y1="111" x2="106" y2="111"/><line x1="142" y1="15" x2="142" y2="111"/><line x1="142" y1="15" x2="238" y2="15"/><line x1="158" y1="15" x2="158" y2="111"/><line x1="142" y1="31" x2="238" y2="31"/><line x1="174" y1="15" x2="174" y2="111"/><line x1="142" y1="47" x2="238" y2="47"/><line x1="190" y1="15" x2="190" y2="111"/><line x1="142" y1="63" x2="238" y2="63"/><line x1="206" y1="15" x2="206" y2="111"/><line x1="142" y1="79" x2="238" y2="79"/><line x1="222" y1="15" x2="222" y2="111"/><line x1="142" y1="95" x2="238" y2="95"/><line x1="238" y1="15" x2="238" y2="111"/><line x1="142" y1="111" x2="238" y2="111"/><line x1="274" y1="15" x2="274" y2="111"/><line x1="274" y1="15" x2="370" y2="15"/><line x1="290" y1="15" x2="290" y2="111"/><line x1="274" y1="31" x2="370" y2="31"/><line x1="306" y1="15" x2="306" y2="111"/><line x1="274" y1="47" x2="370" y2="47"/><line x1="322" y1="15" x2="322" y2="111"/><line x1="274" y1="63" x2="370" y2="63"/><line x1="338" y1="15" x2="338" y2="111"/><line x1="274" y1="79" x2="370" y2="79"/><line x1="354" y1="15" x2="354" y2="111"/><line x1="274" y1="95" x2="370" y2="95"/><line x1="370" y1="15" x2="370" y2="111"/><line x1="274" y1="111" x2="370" y2="111"/></g><g stroke="#000" stroke-width="1.2"><rect x="58" y="63" width="16" height="16" fill="#d8d8d8"/><rect x="206" y="79" width="16" height="16" fill="#6f6f6f"/><rect x="206" y="47" width="16" height="16" fill="#6f6f6f"/><rect x="174" y="79" width="16" height="16" fill="#6f6f6f"/><rect x="174" y="47" width="16" height="16" fill="#6f6f6f"/><rect x="190" y="63" width="16" height="16" fill="#d8d8d8"/><rect x="338" y="79" width="16" height="16" fill="#6f6f6f"/><rect x="338" y="47" width="16" height="16" fill="#6f6f6f"/><rect x="306" y="79" width="16" height="16" fill="#6f6f6f"/><rect x="306" y="47" width="16" height="16" fill="#6f6f6f"/><rect x="322" y="63" width="16" height="16" fill="#d8d8d8"/><rect x="354" y="63" width="16" height="16" fill="#d8d8d8"/><rect x="290" y="63" width="16" height="16" fill="#d8d8d8"/><rect x="322" y="95" width="16" height="16" fill="#d8d8d8"/><rect x="322" y="31" width="16" height="16" fill="#d8d8d8"/><rect x="354" y="95" width="16" height="16" fill="#d8d8d8"/><rect x="354" y="31" width="16" height="16" fill="#d8d8d8"/><rect x="290" y="95" width="16" height="16" fill="#d8d8d8"/><rect x="290" y="31" width="16" height="16" fill="#d8d8d8"/></g><g font-size="12" text-anchor="middle"><text x="58" y="127">1. obrazec</text><text x="190" y="127">2. obrazec</text><text x="322" y="127">3. obrazec</text></g></svg>',
  'obrazce-sit.svg',
  'První, druhý a třetí obrazec ve čtvercové síti: 1 světlé pole; 5 polí (1 světlé a 4 tmavá v úhlopříčných rozích); 13 polí (9 světlých a 4 tmavá).',
  'Obrazce ve čtvercové síti (1., 2. a 3. obrazec)',
  new List<String>{'Počet polí $n$-tého obrazce je $2n^2-2n+1$ (postupně $1, 5, 13, \\ldots$); přechodem od $(n-1)$-tého k $n$-tému obrazci přibude $4(n-1)$ polí.','16.1 Z 8. na 9. obrazec přibude $4\\cdot(9-1)=32$ polí.','16.2 Tmavá pole přibývají jen u sudých obrazců; pro sudé $n$ je jejich počet $n^2$. V 10. obrazci je $10^2=100$ tmavých polí a $181-100=81$ světlých polí, liší se tedy o $100-81=19$.','16.3 Počet tmavých polí je $400$ pro dva obrazce: pro sudý $n=20$ (tmavých $n^2=400$) a pro lichý $n=21$ (tmavých $(n-1)^2=400$). Počet světlých polí je pak $(n-1)^2=361$ (pro $n=20$), resp. $n^2=441$ (pro $n=21$).'},
  '16.1: $32$ polí; 16.2: o $19$; 16.3: $361$ nebo $441$ světlých polí',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
