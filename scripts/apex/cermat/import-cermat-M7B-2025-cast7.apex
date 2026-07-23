String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD25C0T02';
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
  'CERMAT M7B 2025 – úloha 14',
  new List<String>{'Helena a Tereza dostávají vždy na začátku měsíce každá na svůj účet kapesné 400 korun. Jiné příjmy dívky nemají a z kapesného během měsíce část utratí. V grafu jsou zaznamenány zůstatky na účtech obou dívek na začátku měsíce po obdržení kapesného. (Tereza začínala v lednu bez úspor.) Všechny zaznamenané hodnoty jsou násobkem 50 korun.','Jakou část z kapesného na 3 měsíce ušetřila Tereza během ledna, února a března?'},
  new List<String>{'A) $\\frac{3}{4}$','B) $\\frac{2}{3}$','C) $\\frac{5}{8}$','D) $\\frac{5}{12}$','E) jinou část'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 300" font-family="sans-serif"><text x="300" y="20" font-size="14" text-anchor="middle" font-weight="bold">Zůstatky na účtech v korunách</text><line x1="120" y1="40" x2="540" y2="40" stroke="#000"/><line x1="120.0" y1="36" x2="120.0" y2="40" stroke="#000"/><text x="120.0" y="32" font-size="10" text-anchor="middle">0</text><line x1="188.0" y1="36" x2="188.0" y2="40" stroke="#000"/><text x="188.0" y="32" font-size="10" text-anchor="middle">200</text><line x1="256.0" y1="36" x2="256.0" y2="40" stroke="#000"/><text x="256.0" y="32" font-size="10" text-anchor="middle">400</text><line x1="324.0" y1="36" x2="324.0" y2="40" stroke="#000"/><text x="324.0" y="32" font-size="10" text-anchor="middle">600</text><line x1="392.0" y1="36" x2="392.0" y2="40" stroke="#000"/><text x="392.0" y="32" font-size="10" text-anchor="middle">800</text><line x1="460.0" y1="36" x2="460.0" y2="40" stroke="#000"/><text x="460.0" y="32" font-size="10" text-anchor="middle">1000</text><line x1="528.0" y1="36" x2="528.0" y2="40" stroke="#000"/><text x="528.0" y="32" font-size="10" text-anchor="middle">1200</text><rect x="120" y="52" width="187.0" height="14" fill="#4d4d4d" stroke="#000"/><rect x="120" y="68" width="136.0" height="14" fill="#d9d9d9" stroke="#000"/><text x="112" y="72" font-size="12" text-anchor="end">Leden</text><rect x="120" y="98" width="255.00000000000003" height="14" fill="#4d4d4d" stroke="#000"/><rect x="120" y="114" width="187.0" height="14" fill="#d9d9d9" stroke="#000"/><text x="112" y="118" font-size="12" text-anchor="end">Únor</text><rect x="120" y="144" width="340.0" height="14" fill="#4d4d4d" stroke="#000"/><rect x="120" y="160" width="306.0" height="14" fill="#d9d9d9" stroke="#000"/><text x="112" y="164" font-size="12" text-anchor="end">Březen</text><rect x="120" y="190" width="391.0" height="14" fill="#4d4d4d" stroke="#000"/><rect x="120" y="206" width="408.00000000000006" height="14" fill="#d9d9d9" stroke="#000"/><text x="112" y="210" font-size="12" text-anchor="end">Duben</text><rect x="470" y="70" width="14" height="14" fill="#4d4d4d" stroke="#000"/><text x="490" y="82" font-size="12">Helena</text><rect x="470" y="92" width="14" height="14" fill="#d9d9d9" stroke="#000"/><text x="490" y="104" font-size="12">Tereza</text><text x="300" y="290" font-size="11" text-anchor="middle">Všechny hodnoty jsou násobkem 50 korun.</text></svg>',
  'graf-zustatky.svg',
  'Vodorovný sloupcový graf zůstatků na účtech Heleny a Terezy za leden až duben v korunách.',
  'Zůstatky na účtech na začátku měsíce',
  new List<String>{'Kapesné za tři měsíce je $3\\cdot 400=1200$ Kč. Zůstatky Terezy: leden 400, únor 550, březen 900, duben 1200 Kč. Utraceno: leden $400+400-550=250$, únor $550+400-900=50$, březen $900+400-1200=100$; celkem $400$ Kč. Ušetřila $1200-400=800$ Kč, tj. $\\frac{800}{1200}=\\frac{2}{3}$.'},
  'B) $\\frac{2}{3}$',
  2, 4, '3',
  new List<String>{'zs2','r7','statistika','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
