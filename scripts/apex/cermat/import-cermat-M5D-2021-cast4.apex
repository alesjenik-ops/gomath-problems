String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD21C0T04';
Integer YEAR = 2021;

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
  'CERMAT M5D 2021 – úloha 8',
  new List<String>{'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary $A$, $B$, $C$ (viz obrázek). Ke každému útvaru doplníme jediný tmavý čtverec tak, aby byl útvar osově souměrný a měl co nejvíce různých os souměrnosti (svislých, vodorovných nebo šikmých).','Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Útvar $A$ doplněný o požadovaný čtverec má $4$ osy souměrnosti.','8.2 Útvar $B$ doplněný o požadovaný čtverec má $2$ osy souměrnosti.','8.3 Útvar $C$ doplněný o požadovaný čtverec má pouze $1$ osu souměrnosti.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 536 150" font-family="sans-serif" font-size="15"><g fill="#a9a9a9"><rect x="84" y="34" width="16" height="16"/><rect x="68" y="50" width="16" height="16"/><rect x="100" y="50" width="16" height="16"/><rect x="52" y="66" width="16" height="16"/><rect x="68" y="82" width="16" height="16"/><rect x="100" y="82" width="16" height="16"/><rect x="84" y="98" width="16" height="16"/><rect x="236" y="34" width="16" height="16"/><rect x="220" y="50" width="16" height="16"/><rect x="236" y="50" width="16" height="16"/><rect x="252" y="66" width="16" height="16"/><rect x="268" y="82" width="16" height="16"/><rect x="268" y="98" width="16" height="16"/><rect x="284" y="98" width="16" height="16"/><rect x="300" y="98" width="16" height="16"/><rect x="284" y="114" width="16" height="16"/><rect x="436" y="50" width="16" height="16"/><rect x="436" y="66" width="16" height="16"/><rect x="468" y="66" width="16" height="16"/><rect x="452" y="82" width="16" height="16"/><rect x="468" y="82" width="16" height="16"/></g><path d="M20 34V130M36 34V130M52 34V130M68 34V130M84 34V130M100 34V130M116 34V130M132 34V130M148 34V130M20 34H148M20 50H148M20 66H148M20 82H148M20 98H148M20 114H148M20 130H148M204 34V130M220 34V130M236 34V130M252 34V130M268 34V130M284 34V130M300 34V130M316 34V130M332 34V130M204 34H332M204 50H332M204 66H332M204 82H332M204 98H332M204 114H332M204 130H332M388 34V130M404 34V130M420 34V130M436 34V130M452 34V130M468 34V130M484 34V130M500 34V130M516 34V130M388 34H516M388 50H516M388 66H516M388 82H516M388 98H516M388 114H516M388 130H516" fill="none" stroke="#000" stroke-width="0.8"/><text x="84" y="22" text-anchor="middle" font-weight="bold">A</text><text x="268" y="22" text-anchor="middle" font-weight="bold">B</text><text x="452" y="22" text-anchor="middle" font-weight="bold">C</text></svg>',
  'utvary-abc.svg',
  'Tři útvary A, B, C složené z tmavých čtverců ve čtvercové síti.',
  'Útvary A, B, C ve čtvercové síti',
  new List<String>{'8.1 Útvar $A$ lze doplnit jedním čtvercem na útvar se čtyřmi osami souměrnosti → Ano.','8.2 Útvar $B$ doplněný jedním čtvercem nemá $2$ osy souměrnosti → Ne.','8.3 Útvar $C$ doplněný jedním čtvercem nemá pouze jednu osu souměrnosti → Ne.'},
  '8.1: Ano; 8.2: Ne; 8.3: Ne',
  4, 5, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
