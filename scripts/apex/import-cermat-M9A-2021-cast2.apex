String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 1. řádný termín (M9A)';
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
  'CERMAT 2021 M9A · úloha 7',
  new List<String>{'Farmářka chová $3$ koně, ale nemá již pro ně žádné krmivo. Chovatel, který má pro svých $5$ koní krmivo na $120$ dní, farmářce dvě pětiny tohoto krmiva prodá. (Každý kůň spotřebuje za den stejné množství krmiva.)','Vypočtěte, za kolik dní','7.1 by veškeré chovatelovo krmivo spotřebovalo všech $8$ koní společně,','7.2 spotřebují chovatelovi koně krmivo, které chovatel neprodá,','7.3 spotřebují farmářčini koně krmivo, které farmářka zakoupí od chovatele.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Celkové množství krmiva $=5\\ \\text{koní}\\cdot120\\ \\text{dní}=600$ koně-dní.','7.1: $600:8=75$ dní.','7.2: chovatel neprodá $\\frac{3}{5}$ krmiva, tj. $\\frac{3}{5}\\cdot600=360$ koně-dní; jeho $5$ koní je spotřebuje za $360:5=72$ dní.','7.3: farmářka koupí $\\frac{2}{5}\\cdot600=240$ koně-dní; její $3$ koně je spotřebují za $240:3=80$ dní.'},
  '7.1: $75$ dní; 7.2: $72$ dní; 7.3: $80$ dní',
  4, 6, '4',
  new List<String>{'zs2','r9','aritmetika','pomer','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PAD21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9A · úloha 8',
  new List<String>{'Síť kolmého čtyřbokého hranolu se skládá ze dvou shodných čtverců a obdélníku s rozměry $40\\ \\mathrm{cm}$ a $8\\ \\mathrm{cm}$ (viz náčrt obrysu sítě). Obdélník tvoří plášť hranolu, jeho delší strana $40\\ \\mathrm{cm}$ odpovídá obvodu čtvercové podstavy a kratší strana $8\\ \\mathrm{cm}$ výšce hranolu.','Vypočtěte','8.1 v cm$^2$ povrch hranolu,','8.2 v cm$^3$ objem hranolu.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 139"><path d="M156 4L196 4L196 44L156 44Z" style="fill:#ffffff;stroke:#7f7f7f;stroke-width:1"/><path d="M28 44L196 44L196 73L28 73Z" style="fill:#ffffff;stroke:#7f7f7f;stroke-width:1"/><path d="M156 73L196 73L196 113L156 113Z" style="fill:#ffffff;stroke:#7f7f7f;stroke-width:1"/><path d="M23 46L23 72C23 72 23 72 23 72C22 72 22 72 22 72L22 46C22 45 22 45 23 45C23 45 23 45 23 46M20 51L23 44L26 51C26 52 26 52 26 52C25 52 25 52 25 52L22 46L23 46L21 52C21 52 20 52 20 52C20 52 19 52 20 51M26 66L23 73L20 66C19 65 20 65 20 65C20 65 21 65 21 65L23 71L22 71L25 65C25 65 25 65 26 65C26 65 26 65 26 66Z" style="fill:#000000"/><path d="M30 120L194 120C194 120 194 119 194 119C194 118 194 118 194 118L30 118C30 118 30 118 30 119C30 119 30 120 30 120M36 116L28 119L36 122C36 122 37 122 37 122C37 121 37 121 37 121L31 118L31 119L37 117C37 117 37 116 37 116C37 116 36 115 36 116M188 122L196 119L188 116C188 115 187 116 187 116C187 116 187 117 187 117L193 119L193 118L187 121C187 121 187 121 187 122C187 122 188 122 188 122Z" style="fill:#000000"/><path d="M156 113L196 113M156 73L156 113M28 73L156 73M28 44L28 73M156 44L28 44M156 4L156 44" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M28 76L28 116" style="fill:none;stroke:#000000;stroke-width:1"/><text x="7" y="64" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8 cm</text><text x="114" y="133" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">40 cm</text></svg>',
  'obr.svg',
  'Náčrt obrysu sítě kolmého čtyřbokého hranolu: dva shodné čtverce (podstavy) a obdélník s rozměry 40 cm a 8 cm (plášť).',
  '',
  new List<String>{'Obvod čtvercové podstavy je $40\\ \\mathrm{cm}$, tedy strana $a=40:4=10\\ \\mathrm{cm}$; výška $h=8\\ \\mathrm{cm}$.','8.1: povrch $S=2a^2+40\\cdot8=2\\cdot100+320=200+320=520\\ \\mathrm{cm}^2$.','8.2: objem $V=a^2\\cdot h=100\\cdot8=800\\ \\mathrm{cm}^3$.'},
  '8.1: $520\\ \\mathrm{cm}^2$; 8.2: $800\\ \\mathrm{cm}^3$',
  3, 5, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','vypocet','bez-kalkulacky'},
  'M9PAD21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
