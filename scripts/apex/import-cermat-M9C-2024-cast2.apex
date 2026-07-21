String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. náhradní termín (M9C)';
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
  'CERMAT 2024 M9C · úloha 6',
  new List<String>{'Pravoúhlý lichoběžník $ABCD$ se základnami $AB$, $CD$ a pravým úhlem při vrcholu $D$ je úhlopříčkou $AC$ rozdělen na trojúhelníky $ABC$ a $ACD$. Platí $|AB|=16\\ \\mathrm{cm}$, $|CD|=6\\ \\mathrm{cm}$, obsah trojúhelníku $ABC$ je $64\\ \\mathrm{cm}^2$.','6.1 Vypočítejte výšku lichoběžníku $ABCD$ (v cm).','6.2 Vypočítejte obsah lichoběžníku $ABCD$ (v $\\mathrm{cm}^2$).'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 441 218"><path d="M4 4L5 4L5 214L4 214Z" style="fill:#000000"/><path d="M136 78L334 78L334 178L136 178Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M136 78L136 178L209 78L136 78Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M335 78L335 178L209 78L335 78Z" style="fill:#ffffff;stroke:#ffffff;stroke-width:2"/><path d="M207 78L332 178M155 79C156 89 149 97 139 98C138 99 138 99 137 99" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M128 179L137 179L137 186L128 186Z" style="fill:#ffffff;stroke:#ffffff;stroke-width:1"/><path d="M143 87C143 87 144 86 144 86C144 86 145 87 145 87C145 87 144 88 144 88C144 88 143 87 143 87Z" style="fill:#000000;stroke:#000000;stroke-width:1"/><text x="66" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Pravoúhlý lichoběžník</text><text x="137" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABCD</text><text x="188" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">se základnami</text><text x="232" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AB</text><text x="244" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="257" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">CD</text><text x="268" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="323" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">s pravým úhlem při</text><text x="394" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">vrcholu</text><text x="47" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je úhlopříčkou</text><text x="91" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AC</text><text x="172" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">rozdělen na dva trojúhelníky</text><text x="256" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABC</text><text x="271" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="287" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ACD</text><text x="300" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="63" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Pro délky stran platí: |</text><text x="123" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AB</text><text x="156" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">| = 16 cm, |</text><text x="190" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">CD</text><text x="269" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">| = 6 cm. Obsah trojúhelníku</text><text x="350" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABC</text><text x="382" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je 64 cm</text><text x="406" y="50" font-size="7" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="410" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="209" y="77" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="174" y="76" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6 cm</text><text x="138" y="77" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="215" y="149" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">64 cm</text><text x="232" y="143" font-size="7" fill="#000" text-anchor="middle" font-family="sans-serif">2</text></svg>',
  'obr.svg',
  'Pravoúhlý lichoběžník ABCD se základnami AB=16 cm, CD=6 cm, úhlopříčkou AC a obsahem trojúhelníku ABC 64 cm².',
  '',
  new List<String>{'6.1: trojúhelník $ABC$ má základnu $AB=16$; $\\frac{16\\cdot v}{2}=64\\Rightarrow v=8\\ \\mathrm{cm}$ (výška lichoběžníku).','6.2: $S=\\frac{(16+6)}{2}\\cdot8=88\\ \\mathrm{cm}^2$.'},
  '6.1: $8\\ \\mathrm{cm}$; 6.2: $88\\ \\mathrm{cm}^2$',
  4, 5, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD24C0T03', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
