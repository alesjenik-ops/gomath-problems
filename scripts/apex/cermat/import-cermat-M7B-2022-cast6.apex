String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD22C0T02';
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
  'CERMAT M7B 2022 – úloha 11',
  new List<String>{'Čtyřúhelník se skládá ze $4$ trojúhelníků (viz obrázek).','Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $16^\\circ$','B) $16^\\circ$','C) $18^\\circ$','D) $21^\\circ$','E) větší než $21^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 270" font-family="sans-serif" font-size="14"> <polygon points="70,45 445,150 240,240 70,240" fill="none" stroke="#000" stroke-width="1.6"/> <line x1="70" y1="45" x2="240" y2="240" stroke="#000"/> <line x1="70" y1="45" x2="300" y2="150" stroke="#000"/> <line x1="240" y1="240" x2="300" y2="150" stroke="#000"/> <line x1="445" y1="150" x2="240" y2="240" stroke="#000"/> <text x="92" y="72">60°</text> <text x="126" y="66" font-style="italic">φ</text> <text x="86" y="214">60°</text> <text x="120" y="232">28°</text> <text x="388" y="152" font-style="italic">φ</text> <rect x="288" y="150" width="11" height="11" fill="none" stroke="#000"/> <rect x="229" y="217" width="11" height="11" fill="none" stroke="#000"/> </svg>',
  'ctyruhelnik-uhly.svg',
  'Schematický nákres čtyřúhelníku složeného ze čtyř trojúhelníků s vyznačenými úhly 60°, 60°, 28°, dvěma pravými úhly a hledaným úhlem φ.',
  'Čtyřúhelník složený ze čtyř trojúhelníků (schematicky)',
  new List<String>{'Levý trojúhelník má u dvou vrcholů úhly $60^\\circ$ a $60^\\circ$, je tedy rovnostranný. Postupným užitím součtu úhlů v trojúhelníku, pravých úhlů vyznačených v obrázku a úhlu $28^\\circ$ dopočítáme hledaný úhel $\\varphi=16^\\circ$.'},
  'B) $16^\\circ$',
  2, 5, '4',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2022 – úloha 12',
  new List<String>{'Domeček tvaru pětiúhelníku se skládá z trojúhelníku a čtyř shodných čtverců. Čtyři čtverce mají dohromady stejný obsah jako trojúhelník. Délka strany čtverce je $6$ cm.','Jaká je výška domečku $h$?'},
  new List<String>{'A) menší než $14$ cm','B) $14$ cm','C) $16$ cm','D) $18$ cm','E) větší než $18$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 250" font-family="sans-serif" font-size="14"> <rect x="40" y="150" width="60" height="60" fill="none" stroke="#000"/> <rect x="100" y="150" width="60" height="60" fill="none" stroke="#000"/> <rect x="160" y="150" width="60" height="60" fill="none" stroke="#000"/> <rect x="220" y="150" width="60" height="60" fill="none" stroke="#000"/> <polygon points="40,150 160,30 280,150" fill="none" stroke="#000" stroke-width="1.6"/> <line x1="300" y1="30" x2="300" y2="210" stroke="#000"/> <line x1="296" y1="30" x2="304" y2="30" stroke="#000"/> <line x1="296" y1="210" x2="304" y2="210" stroke="#000"/> <text x="311" y="126" font-style="italic">h</text> </svg>',
  'domecek.svg',
  'Schematický nákres domečku ve tvaru pětiúhelníku: čtyři shodné čtverce v řadě a nad nimi trojúhelníková střecha; vpravo je vyznačena výška h.',
  'Domeček z trojúhelníku a čtyř shodných čtverců (schematicky)',
  new List<String>{'Obsah čtyř čtverců je $4\\cdot6^2=144$ cm², stejný obsah má i trojúhelníková střecha. Základna střechy je $4\\cdot6=24$ cm, proto pro její výšku $v$ platí $\\frac{1}{2}\\cdot24\\cdot v=144$, tj. $v=12$ cm. Výška domečku $h=6+12=18$ cm.'},
  'D) $18$ cm',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
