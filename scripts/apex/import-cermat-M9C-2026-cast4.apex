String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 1. náhradní termín (M9C)';
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
  'CERMAT 2026 M9C · úloha 8',
  new List<String>{'V náčrtku pravidelného pětiúhelníku $ABCDE$ jsou vyznačeny dvě z jeho os souměrnosti $o_1$, $o_2$, jejich průsečík $S$, úsečka $AD$ a velikost úhlu $36^\\circ$ (viz obrázek).','Vypočtěte ve stupních velikost úhlu (velikosti neměřte, ale vypočtěte):','8.1 $\\varphi$,','8.2 $\\omega$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 230"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 56L466 56Z" style="fill:#000000"/><path d="M466 56L467 56L467 71L466 71Z" style="fill:#000000"/><path d="M466 71L467 71L467 90L466 90Z" style="fill:#000000"/><path d="M466 90L467 90L467 109L466 109Z" style="fill:#000000"/><path d="M466 109L467 109L467 128L466 128Z" style="fill:#000000"/><path d="M466 128L467 128L467 147L466 147Z" style="fill:#000000"/><path d="M466 147L467 147L467 166L466 166Z" style="fill:#000000"/><path d="M466 166L467 166L467 185L466 185Z" style="fill:#000000"/><path d="M466 185L467 185L467 203L466 203Z" style="fill:#000000"/><path d="M4 225L466 225L466 226L4 226Z" style="fill:#000000"/><path d="M466 225L467 225L467 226L466 226Z" style="fill:#000000"/><path d="M466 225L467 225L467 226L466 226Z" style="fill:#000000"/><path d="M466 203L467 203L467 225L466 225Z" style="fill:#000000"/><path d="M278 87L362 33L445 87L411 194L316 194L278 87" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M361 213L361 15M361 179C370 179 377 186 377 194M418 37L307 208M417 68C412 76 402 78 395 73M362 33L316 194M361 171C353 170 344 168 337 163M382 46C377 53 370 57 362 57M354 60C347 58 342 54 338 48" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M367 187C367 187 367 186 368 186C369 186 369 187 369 187C369 188 369 188 368 188C367 188 367 188 367 187Z" style="fill:#000000"/><path d="M404 69C404 68 405 67 405 67C406 67 406 68 406 69C406 69 406 70 405 70C405 70 404 69 404 69Z" style="fill:#000000"/><text x="319" y="209" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="414" y="209" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="453" y="92" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="370" y="32" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="273" y="92" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text><text x="367" y="213" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text><text x="372" y="214" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">1</text><text x="421" y="48" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text><text x="426" y="50" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="368" y="134" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="350" y="165" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">36</text><text x="358" y="165" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="369" y="51" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝜑</text><text x="349" y="54" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝜔</text></svg>',
  'obr.svg',
  'Náčrtek pravidelného pětiúhelníku ABCDE se dvěma osami souměrnosti o1, o2, průsečíkem S, úsečkou AD a vyznačeným úhlem 36 stupňů.',
  '',
  new List<String>{'Vnitřní úhel pravidelného pětiúhelníku je $108^\\circ$; osa souměrnosti tento úhel půlí.','8.1: $\\varphi=54^\\circ$.','8.2: $\\omega=36^\\circ$.'},
  '8.1: $\\varphi=54^\\circ$; 8.2: $\\omega=36^\\circ$',
  3, 5, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD26C0T03', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
