String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD26C0T04';
Integer YEAR = 2026;

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
  'CERMAT M9D 2026 – úloha 5',
  new List<String>{'Na výstavbě kanalizace se podílí tři firmy: Roura, Trubka a Potrubí. Každá z nich staví jeden souvislý úsek kanalizace. Úsek stavěný firmou Roura je dvakrát delší než úsek stavěný firmou Trubka. Úsek stavěný firmou Potrubí má čtyřikrát menší délku, než mají dohromady úseky stavěné oběma zbývajícími firmami. Délku úseku, který staví firma Roura, označíme $r$.','5.1 Vyjádřete výrazem s proměnnou $r$ délku úseku, který staví firma Trubka.','5.2 Vyjádřete výrazem s proměnnou $r$ délku úseku, který staví firma Potrubí.','5.3 Firma Potrubí staví úsek o $12$ km kratší než firma Trubka. Vypočtěte v km délku úseku, který staví firma Roura.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Roura staví dvakrát delší úsek než Trubka, tedy Trubka staví $\\frac{r}{2}$.','5.2 Potrubí má čtyřikrát menší délku než součet úseků Roura a Trubka: $\\frac{1}{4}\\left(r+\\frac{r}{2}\\right)=\\frac{1}{4}\\cdot\\frac{3r}{2}=\\frac{3}{8}r$.','5.3 Potrubí staví o $12$ km méně než Trubka: $\\frac{r}{2}-\\frac{3}{8}r=\\frac{r}{8}=12$, tedy $r=96$ km.'},
  '5.1: $\\frac{r}{2}$; 5.2: $\\frac{3}{8}r$; 5.3: $96$ km',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2026 – úloha 6',
  new List<String>{'Obdélník $ABCD$ je složen z bílého a šedého obdélníku jako na obrázku. Obvod obdélníku $ABCD$ je $68$ cm a délka strany $BC$ je $10$ cm. Obvod šedého obdélníku je o $12$ cm větší než obvod bílého obdélníku.','6.1 Vypočtěte v cm délku strany $AB$ obdélníku $ABCD$.','6.2 Vypočtěte v cm² obsah šedého obdélníku.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 200" font-family="sans-serif"> <rect x="70" y="40" width="288" height="120" fill="#ffffff" stroke="#000" stroke-width="2"/> <rect x="178" y="40" width="180" height="120" fill="#b8b8b8" stroke="#000" stroke-width="2"/> <text x="60" y="34" font-size="15" font-style="italic">D</text> <text x="352" y="34" font-size="15" font-style="italic">C</text> <text x="60" y="180" font-size="15" font-style="italic">A</text> <text x="352" y="180" font-size="15" font-style="italic">B</text> </svg>',
  'obdelnik-ABCD.svg',
  'Obdélník ABCD (D vlevo nahoře, C vpravo nahoře, A vlevo dole, B vpravo dole) rozdělený svislou čarou na bílý obdélník vlevo a šedý obdélník vpravo.',
  'Obdélník ABCD složený z bílého a šedého obdélníku',
  new List<String>{'6.1 Obvod obdélníku $ABCD$ je $68$ cm, tedy $AB+BC=34$ cm; při $BC=10$ cm je $AB=24$ cm.','6.2 Bílý i šedý obdélník mají výšku $BC=10$ cm; jejich šířky $b$ a $g$ splňují $b+g=24$. Obvody se liší o $12$ cm: $2(g-b)=12$, tedy $g-b=6$. Odtud $g=15$ cm, $b=9$ cm. Obsah šedého obdélníku $=15\\cdot 10=150$ cm².'},
  '6.1: $24$ cm; 6.2: $150$ cm²',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
