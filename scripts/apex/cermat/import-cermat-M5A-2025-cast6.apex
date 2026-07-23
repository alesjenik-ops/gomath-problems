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
  'CERMAT M5A 2025 – úloha 11',
  new List<String>{'Ve čtvercové síti jsou zakresleny trojúhelníky $ABC$, $KLM$ a čtverec $DEFG$. Vrcholy všech těchto obrazců leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky 1 cm a obsah 1 cm².','O kolik cm se liší obvod trojúhelníku $ABC$ a obvod čtverce $DEFG$?'},
  new List<String>{'A) o méně než 2 cm','B) o 2 cm','C) o 3 cm','D) o 4 cm','E) o jinou délku'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 190" font-family="sans-serif"><line x1="30" y1="168" x2="30" y2="24" stroke="#bbb"/><line x1="54" y1="168" x2="54" y2="24" stroke="#bbb"/><line x1="78" y1="168" x2="78" y2="24" stroke="#bbb"/><line x1="102" y1="168" x2="102" y2="24" stroke="#bbb"/><line x1="126" y1="168" x2="126" y2="24" stroke="#bbb"/><line x1="150" y1="168" x2="150" y2="24" stroke="#bbb"/><line x1="174" y1="168" x2="174" y2="24" stroke="#bbb"/><line x1="198" y1="168" x2="198" y2="24" stroke="#bbb"/><line x1="222" y1="168" x2="222" y2="24" stroke="#bbb"/><line x1="246" y1="168" x2="246" y2="24" stroke="#bbb"/><line x1="270" y1="168" x2="270" y2="24" stroke="#bbb"/><line x1="294" y1="168" x2="294" y2="24" stroke="#bbb"/><line x1="318" y1="168" x2="318" y2="24" stroke="#bbb"/><line x1="342" y1="168" x2="342" y2="24" stroke="#bbb"/><line x1="366" y1="168" x2="366" y2="24" stroke="#bbb"/><line x1="390" y1="168" x2="390" y2="24" stroke="#bbb"/><line x1="414" y1="168" x2="414" y2="24" stroke="#bbb"/><line x1="30" y1="24" x2="414" y2="24" stroke="#bbb"/><line x1="30" y1="48" x2="414" y2="48" stroke="#bbb"/><line x1="30" y1="72" x2="414" y2="72" stroke="#bbb"/><line x1="30" y1="96" x2="414" y2="96" stroke="#bbb"/><line x1="30" y1="120" x2="414" y2="120" stroke="#bbb"/><line x1="30" y1="144" x2="414" y2="144" stroke="#bbb"/><line x1="30" y1="168" x2="414" y2="168" stroke="#bbb"/><polygon points="30,168 126,168 78,72" fill="#9a9a9a" stroke="#000" stroke-width="2"/><polygon points="174,144 222,120 198,72 150,96" fill="#9a9a9a" stroke="#000" stroke-width="2"/><polygon points="246,144 366,144 294,96" fill="#9a9a9a" stroke="#000" stroke-width="2"/><text x="16" y="182" font-size="13" font-style="italic">A</text><text x="130" y="184" font-size="13" font-style="italic">B</text><text x="74" y="66" font-size="13" font-style="italic">C</text><text x="170" y="160" font-size="13" font-style="italic">D</text><text x="228" y="124" font-size="13" font-style="italic">E</text><text x="196" y="66" font-size="13" font-style="italic">F</text><text x="136" y="100" font-size="13" font-style="italic">G</text><text x="234" y="158" font-size="13" font-style="italic">K</text><text x="370" y="158" font-size="13" font-style="italic">L</text><text x="292" y="90" font-size="13" font-style="italic">M</text><rect x="390" y="144" width="24" height="24" fill="#d8d8d8" stroke="#bbb"/><text x="417" y="136.0" font-size="9">1 cm²</text></svg>',
  'sit-obrazce.svg',
  'Čtvercová síť s trojúhelníkem ABC, čtvercem DEFG a trojúhelníkem KLM; vrcholy v mřížových bodech.',
  'Obrazce ve čtvercové síti (schematicky)',
  new List<String>{'Trojúhelník $ABC$ je rovnoramenný se základnou $AB = 4$ cm a rameny délky $\\sqrt{2^2 + 4^2} = 2\\sqrt{5}$ cm; jeho obvod je $4 + 4\\sqrt{5}$ cm. Čtverec $DEFG$ má stranu $\\sqrt{1^2 + 2^2} = \\sqrt{5}$ cm, obvod $4\\sqrt{5}$ cm. Rozdíl obvodů je $(4 + 4\\sqrt{5}) - 4\\sqrt{5} = 4$ cm.'},
  'D) o 4 cm',
  2, 3, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
