String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M7A 2015 – úloha 13',
  new List<String>{'Obrazec, který představuje síť krychle, má obvod 28 cm (viz obrázek).','Jaký je objem krychle?'},
  new List<String>{'A) méně než 9 cm³','B) 9 cm³','C) 16 cm³','D) 27 cm³','E) více než 27 cm³'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 240" font-family="sans-serif"><rect x="60" y="90" width="60" height="60" fill="#d9d9d9" stroke="#8a8a8a" stroke-dasharray="6 4"/><rect x="120" y="90" width="60" height="60" fill="#d9d9d9" stroke="#8a8a8a" stroke-dasharray="6 4"/><rect x="180" y="90" width="60" height="60" fill="#d9d9d9" stroke="#8a8a8a" stroke-dasharray="6 4"/><rect x="240" y="90" width="60" height="60" fill="#d9d9d9" stroke="#8a8a8a" stroke-dasharray="6 4"/><rect x="120" y="30" width="60" height="60" fill="#d9d9d9" stroke="#8a8a8a" stroke-dasharray="6 4"/><rect x="180" y="150" width="60" height="60" fill="#d9d9d9" stroke="#8a8a8a" stroke-dasharray="6 4"/><path d="M60,90 L120,90 L120,30 L180,30 L180,90 L300,90 L300,150 L240,150 L240,210 L180,210 L180,150 L60,150 z" fill="none" stroke="#000" stroke-width="2.5"/></svg>',
  'sit-krychle.svg',
  'Síť krychle tvaru kříže: čtyři čtverce v řadě, jeden čtverec nad druhým z nich a jeden pod třetím z nich.',
  'Síť krychle',
  new List<String>{'Síť má 6 čtverců; sdílených (vnitřních) hran je 5, takže obvod tvoří $6\\cdot 4-2\\cdot 5=14$ hran.','Platí $14a=28$, tedy $a=2$ cm.','Objem krychle je $V=2^3=8$ cm³, což je méně než 9 cm³.'},
  'A) méně než 9 cm³',
  2, 4, '4',
  new List<String>{'zs2','r7','stereometrie','porozumeni','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2015 – úloha 14',
  new List<String>{'Na obrázku jsou dvě rovnoběžné přímky (vyznačeny shodnými značkami) a trojúhelník s úhly $\\alpha$ a $\\beta$. U společného vrcholu na horní přímce jsou vyznačeny úhly $64^\\circ$ a $68^\\circ$.','Jakou velikost má úhel $\\beta$?'},
  new List<String>{'A) $32^\\circ$','B) $36^\\circ$','C) $42^\\circ$','D) $48^\\circ$','E) jinou velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"><line x1="55" y1="60" x2="420" y2="60" stroke="#000" stroke-width="2"/><line x1="55" y1="260" x2="425" y2="260" stroke="#000" stroke-width="2"/><line x1="200" y1="60" x2="102" y2="260" stroke="#000" stroke-width="2"/><line x1="200" y1="60" x2="380" y2="260" stroke="#000" stroke-width="2"/><line x1="298" y1="50" x2="298" y2="70" stroke="#000" stroke-width="2"/><line x1="306" y1="50" x2="306" y2="70" stroke="#000" stroke-width="2"/><line x1="238" y1="250" x2="238" y2="270" stroke="#000" stroke-width="2"/><line x1="246" y1="250" x2="246" y2="270" stroke="#000" stroke-width="2"/><path d="M145,60 A55,55 0 0 0 176,109" fill="none" stroke="#000" stroke-width="1.6"/><path d="M182,96 A40,40 0 0 0 227,90" fill="none" stroke="#000" stroke-width="1.6"/><path d="M142,260 A40,40 0 0 0 120,224" fill="none" stroke="#000" stroke-width="1.6"/><path d="M340,260 A40,40 0 0 1 353,230" fill="none" stroke="#000" stroke-width="1.6"/><text x="152" y="96" font-size="15">64°</text><text x="192" y="112" font-size="15">68°</text><text x="120" y="253" font-size="17" font-style="italic">α</text><text x="346" y="253" font-size="17" font-style="italic">β</text></svg>',
  'uhly-rovnobezky.svg',
  'Dvě rovnoběžné přímky; z vrcholu na horní přímce vedou dvě polopřímky k dolní přímce, u vrcholu jsou úhly 64 stupňů a 68 stupňů, u dolní přímky úhly alfa a beta.',
  'Výchozí obrázek k úloze 14',
  new List<String>{'U vrcholu na horní přímce je přímý úhel: zbývající úhel má velikost $180^\\circ-64^\\circ-68^\\circ=48^\\circ$.','Tento úhel a úhel $\\beta$ jsou střídavé úhly u rovnoběžek, proto $\\beta=48^\\circ$.'},
  'D) $48^\\circ$',
  2, 3, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
