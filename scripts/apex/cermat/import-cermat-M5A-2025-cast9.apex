String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD25C0T01';
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
  'CERMAT M5A 2025 – úloha 14',
  new List<String>{'Poutník měl u sebe 54 dukátů, stejně jako kouzelník. Kouzelník mu prozradil kouzlo: Když mi dáš právě tolik dukátů, abys měl polovinu toho, co budu mít i s darovanými dukáty já, zbytek tvých dukátů se zdvojnásobí a budeme mít opět stejně. Pokud to však zkusíš, ale nedokážeš, o všechny dukáty přijdeš.','14.1 Poutník dal kouzelníkovi správný počet dukátů a zbytek dukátů se mu zdvojnásobil. Určete, kolik dukátů dal poutník kouzelníkovi.','14.2 Protože kouzlo poprvé fungovalo, poutník jej použil ještě jednou. Vypočtěte, kolik dukátů měl poutník, když se kouzlo vyplnilo podruhé.','14.3 Poutník kouzla několikrát využil. Když si správně spočítal, že už pomocí kouzla nemůže další dukáty získat a že by při dalším pokusu určitě o všechny přišel, dál nepokračoval. Vypočtěte, kolik dukátů měl poutník, když se s kouzelníkem rozloučil.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Poutník i kouzelník mají po $54$ dukátech. Poutník dá $x$ dukátů; pak má $54 - x$, což má být polovina kouzelníkových $54 + x$: $54 - x = \\frac{54 + x}{2}$, odtud $x = 18$. Poté se zbytek poutníkových dukátů zdvojnásobí.','14.1 Poutník dal kouzelníkovi $18$ dukátů (zbylo mu $36$, po zdvojnásobení $72$; kouzelník má také $72$).','14.2 Podruhé z $72$ dukátů dá $24$, zbylých $48$ se zdvojnásobí na $96$; poutník má $96$ dukátů (i kouzelník $96$).','14.3 Oba mají postupně $54, 72, 96, 128$ dukátů. Z $128$ už nelze dát celý potřebný počet dukátů ($128$ není dělitelné třemi), poutník tedy skončil se $128$ dukáty.'},
  '14.1: $18$ dukátů; 14.2: $96$ dukátů; 14.3: $128$ dukátů',
  4, 7, '4',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
