String SRC   = 'CERMAT – Ilustrační test 2019, matematika 9 (čtyřleté obory)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2019 M9I · úloha 16',
  new List<String>{'Na kruhové autodráze jezdila v sousedních drahách dvě autíčka – první ve vnitřní dráze, druhé ve vnější. Obě autíčka vystartovala současně z jedné startovní čáry. První autíčko ujelo každá $4$ kola za stejnou dobu, za kterou druhé autíčko ujelo $3$ kola. Během jízdy autíčka neměnila svou rychlost.','16.1 \\quad Obě autíčka vystartovala stejným směrem. První autíčko ujelo prvních $10$ kol. Určete, kolikrát během této jízdy dostihlo druhé autíčko.','16.2 \\quad Obě autíčka vystartovala stejným směrem. Druhé autíčko ujelo prvních $50$ kol. Určete, kolikrát ho během této jízdy dostihlo první autíčko.','16.3 \\quad Druhé autíčko vystartovalo v opačném směru než první autíčko. Druhé autíčko ujelo prvních $5$ kol. Určete, kolikrát se během této jízdy obě autíčka minula. (Poprvé se obě autíčka minula hned po startu.)'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Poměr počtu ujetých kol je první$\\,$:$\\,$druhé $=4:3$.','16.1: když první ujede $10$ kol, druhé ujede $10\\cdot\\frac{3}{4}=7{,}5$ kola. Při stejném směru dostihne první druhé po každém získaném celém kole: $\\lfloor 10-7{,}5\\rfloor=\\lfloor 2{,}5\\rfloor=2$ — \\textbf{2krát}.','16.2: když druhé ujede $50$ kol, první ujede $50\\cdot\\frac{4}{3}=66\\frac{2}{3}$ kola; rozdíl $66\\frac{2}{3}-50=16\\frac{2}{3}$, tedy $\\lfloor 16\\frac{2}{3}\\rfloor=16$ — \\textbf{16krát}.','16.3: při opačných směrech se autíčka minou vždy, když součet jimi ujetých kol vzroste o celé kolo. Když druhé ujede $5$ kol, první ujede $5\\cdot\\frac{4}{3}=6\\frac{2}{3}$ kola; součet je $5+6\\frac{2}{3}=11\\frac{2}{3}$. Minutí nastanou pro součty $0,1,2,\\dots,11$ (první hned po startu) — celkem \\textbf{12krát}.'},
  '16.1: 2krát; 16.2: 16krát; 16.3: 12krát',
  4, 8, '5',
  new List<String>{'zs2','r9','pomer','aritmetika','posloupnosti','uvazovani','slovni','bez-kalkulacky'},
  'M9PID19C0T01', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
