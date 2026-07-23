String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD22C0T04';
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
  'CERMAT M5D 2022 – úloha 8',
  new List<String>{'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary $A$, $B$, $C$. Každý z nich má pouze jednu osu souměrnosti. V každém útvaru přemístíme jediný tmavý čtverec tak, aby měl upravený útvar co nejvíce různých os souměrnosti (svislých, vodorovných nebo šikmých).','Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Správně upravený útvar $A$ má pouze 2 osy souměrnosti.','8.2 Správně upravený útvar $B$ má pouze 2 osy souměrnosti.','8.3 Správně upravený útvar $C$ má pouze 1 osu souměrnosti.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200" font-family="sans-serif"><text x="100.0" y="26" font-size="16" text-anchor="middle">A</text><rect x="80" y="40" width="20" height="20" fill="#9a9a9a"/><rect x="100" y="40" width="20" height="20" fill="#9a9a9a"/><rect x="60" y="60" width="20" height="20" fill="#9a9a9a"/><rect x="120" y="60" width="20" height="20" fill="#9a9a9a"/><rect x="40" y="80" width="20" height="20" fill="#9a9a9a"/><rect x="60" y="80" width="20" height="20" fill="#9a9a9a"/><rect x="120" y="80" width="20" height="20" fill="#9a9a9a"/><rect x="140" y="80" width="20" height="20" fill="#9a9a9a"/><rect x="40" y="100" width="20" height="20" fill="#9a9a9a"/><rect x="80" y="100" width="20" height="20" fill="#9a9a9a"/><rect x="40" y="120" width="20" height="20" fill="#9a9a9a"/><rect x="60" y="120" width="20" height="20" fill="#9a9a9a"/><rect x="120" y="120" width="20" height="20" fill="#9a9a9a"/><rect x="140" y="120" width="20" height="20" fill="#9a9a9a"/><rect x="60" y="140" width="20" height="20" fill="#9a9a9a"/><rect x="120" y="140" width="20" height="20" fill="#9a9a9a"/><rect x="80" y="160" width="20" height="20" fill="#9a9a9a"/><rect x="100" y="160" width="20" height="20" fill="#9a9a9a"/><path d="M20 40V180M40 40V180M60 40V180M80 40V180M100 40V180M120 40V180M140 40V180M160 40V180M180 40V180M20 40H180M20 60H180M20 80H180M20 100H180M20 120H180M20 140H180M20 160H180M20 180H180" stroke="#333" stroke-width="1" fill="none"/><text x="300.0" y="26" font-size="16" text-anchor="middle">B</text><rect x="240" y="60" width="20" height="20" fill="#9a9a9a"/><rect x="260" y="60" width="20" height="20" fill="#9a9a9a"/><rect x="300" y="60" width="20" height="20" fill="#9a9a9a"/><rect x="320" y="60" width="20" height="20" fill="#9a9a9a"/><rect x="240" y="80" width="20" height="20" fill="#9a9a9a"/><rect x="280" y="80" width="20" height="20" fill="#9a9a9a"/><rect x="320" y="80" width="20" height="20" fill="#9a9a9a"/><rect x="220" y="100" width="20" height="20" fill="#9a9a9a"/><rect x="360" y="100" width="20" height="20" fill="#9a9a9a"/><rect x="240" y="120" width="20" height="20" fill="#9a9a9a"/><rect x="320" y="120" width="20" height="20" fill="#9a9a9a"/><rect x="240" y="140" width="20" height="20" fill="#9a9a9a"/><rect x="260" y="140" width="20" height="20" fill="#9a9a9a"/><rect x="300" y="140" width="20" height="20" fill="#9a9a9a"/><rect x="320" y="140" width="20" height="20" fill="#9a9a9a"/><rect x="280" y="160" width="20" height="20" fill="#9a9a9a"/><path d="M220 40V180M240 40V180M260 40V180M280 40V180M300 40V180M320 40V180M340 40V180M360 40V180M380 40V180M220 40H380M220 60H380M220 80H380M220 100H380M220 120H380M220 140H380M220 160H380M220 180H380" stroke="#333" stroke-width="1" fill="none"/><text x="500.0" y="26" font-size="16" text-anchor="middle">C</text><rect x="500" y="60" width="20" height="20" fill="#9a9a9a"/><rect x="460" y="80" width="20" height="20" fill="#9a9a9a"/><rect x="480" y="80" width="20" height="20" fill="#9a9a9a"/><rect x="460" y="100" width="20" height="20" fill="#9a9a9a"/><rect x="500" y="100" width="20" height="20" fill="#9a9a9a"/><rect x="540" y="100" width="20" height="20" fill="#9a9a9a"/><rect x="440" y="120" width="20" height="20" fill="#9a9a9a"/><rect x="480" y="120" width="20" height="20" fill="#9a9a9a"/><rect x="500" y="120" width="20" height="20" fill="#9a9a9a"/><rect x="520" y="120" width="20" height="20" fill="#9a9a9a"/><rect x="500" y="140" width="20" height="20" fill="#9a9a9a"/><rect x="480" y="160" width="20" height="20" fill="#9a9a9a"/><path d="M420 40V180M440 40V180M460 40V180M480 40V180M500 40V180M520 40V180M540 40V180M560 40V180M580 40V180M420 40H580M420 60H580M420 80H580M420 100H580M420 120H580M420 140H580M420 160H580M420 180H580" stroke="#333" stroke-width="1" fill="none"/></svg>',
  'utvary-abc.svg',
  'Tři útvary A, B, C složené z šedých čtverců ve čtvercové síti (schematicky).',
  'Útvary A, B, C ve čtvercové síti',
  new List<String>{'8.1 Útvar $A$ lze přemístěním jednoho čtverce upravit tak, aby měl přesně 2 osy souměrnosti – tvrzení je pravdivé (A).','8.2 Nejlepší úpravou útvaru $B$ vznikne útvar s více než 2 osami souměrnosti, takže tvrzení o pouze 2 osách je nepravdivé (N).','8.3 Nejlepší úpravou útvaru $C$ vznikne útvar s více než 1 osou souměrnosti, takže tvrzení o pouze 1 ose je nepravdivé (N).'},
  '8.1: Ano; 8.2: Ne; 8.3: Ne',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
