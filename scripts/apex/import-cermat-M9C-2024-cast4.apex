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
  'CERMAT 2024 M9C · úloha 8',
  new List<String>{'Trojúhelník $ABC$ je vymezen třemi různoběžkami $a$, $b$, $c$. Přímky $a$ a $c$ svírají úhel $130^\\circ$ a velikosti úhlů $\\alpha$ a $\\gamma$ jsou v poměru $2:3$ (viz obrázek).','8.1 Vypočítejte velikost vnitřního úhlu $\\gamma$ při vrcholu $C$.','8.2 Vypočítejte rozdíl $\\alpha-\\beta$ vnitřních úhlů.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 451 266"><path d="M39 195L211 44M146 44L336 262M46 141L354 238" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M275 192C288 178 310 177 325 190C336 201 339 218 332 232M199 104C184 117 162 115 149 100C149 99 149 99 149 99M123 122C137 134 141 152 135 169M229 198C230 183 238 170 251 164" style="fill:none;stroke:#000000;stroke-width:1"/><text x="7" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Trojúhelník</text><text x="46" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABC</text><text x="139" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je vymezen třemi různoběžkami</text><text x="224" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="230" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="235" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">b</text><text x="241" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="246" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">c</text><text x="270" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">. Přímky</text><text x="294" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="302" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="310" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">c</text><text x="351" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">svírají úhel 130</text><text x="392" y="12" font-size="7" fill="#000" text-anchor="middle" font-family="sans-serif">o</text><text x="16" y="33" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a velikosti úhlů</text><text x="58" y="33" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">α</text><text x="67" y="33" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="75" y="33" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">γ</text><text x="126" y="33" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">jsou v poměru 2:3.</text><text x="254" y="196" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">β</text><text x="85" y="175" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="57" y="143" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">c</text><text x="176" y="67" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="212" y="65" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">b</text><text x="295" y="238" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="119" y="153" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">α</text><text x="176" y="100" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">γ</text><text x="307" y="213" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">130</text><text x="321" y="207" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">o</text></svg>',
  'obr.svg',
  'Trojúhelník ABC vymezený třemi různoběžkami a, b, c; přímky a a c svírají úhel 130°, vyznačeny vnitřní úhly alfa, beta, gama.',
  '',
  new List<String>{'Vnitřní úhel $\\beta=180^\\circ-130^\\circ=50^\\circ$; pak $\\alpha+\\gamma=130^\\circ$ a $\\alpha:\\gamma=2:3$.','8.1: $\\gamma=\\frac{3}{5}\\cdot130^\\circ=78^\\circ$.','8.2: $\\alpha=\\frac{2}{5}\\cdot130^\\circ=52^\\circ$; $\\alpha-\\beta=52^\\circ-50^\\circ=2^\\circ$.'},
  '8.1: $\\gamma=78^\\circ$; 8.2: $\\alpha-\\beta=2^\\circ$',
  4, 5, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD24C0T03', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
