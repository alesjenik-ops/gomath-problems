String SRC   = 'CERMAT – Ilustrační test 2020, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2020 M9I · úloha 12',
  new List<String>{'Na úsečce $AB$ leží bod $D$, na polopřímce $AE$ bod $C$ (viz obrázek). Úsečky $AC$, $CD$ a $BD$ mají stejnou délku $d$. Úhel $ACD$ má velikost $120^\\circ$.','V obrázku je $\\alpha$ úhel při vrcholu $A$, $\\beta$ úhel při vrcholu $B$ a $\\varphi$ úhel mezi polopřímkou $CE$ a úsečkou $CB$.','Jaký je součet úhlů $\\alpha+\\beta+\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $90^\\circ$','B) $85^\\circ$','C) $80^\\circ$','D) $75^\\circ$','E) jiná velikost'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 223 117"><path d="M10 96L210 96M10 96L124 11M72 50L133 96M72 50L210 96M115 14L119 19" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M52 65C60 76 76 78 87 70C89 68 90 67 92 65M43 96C43 89 41 82 37 76M97 59C100 50 99 41 93 34M153 77C151 83 150 90 150 96" style="fill:none;stroke:#000000;stroke-width:1"/><text x="7" y="111" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="70" y="46" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="213" y="111" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="134" y="111" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="69" y="72" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">120</text><text x="81" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="34" y="94" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text><text x="159" y="93" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛽</text><text x="92" y="51" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝜑</text><text x="37" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝑑</text><text x="96" y="85" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝑑</text><text x="172" y="109" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝑑</text><text x="116" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text></svg>',
  'obr.svg',
  'Úsečka AB s bodem D, polopřímka AE s bodem C; AC=CD=BD=d, úhel ACD je 120°, vyznačeny úhly alfa při A, beta při B a fí u C.',
  '',
  new List<String>{'Trojúhelník $ACD$ je rovnoramenný ($AC=CD$) s úhlem $120^\\circ$ při vrcholu $C$, proto $\\alpha=\\angle DAC=\\frac{180^\\circ-120^\\circ}{2}=30^\\circ$ a $\\angle ADC=30^\\circ$.','Úhel $CDB=180^\\circ-30^\\circ=150^\\circ$; trojúhelník $CDB$ je rovnoramenný ($CD=BD$), takže $\\beta=\\angle DBC=\\frac{180^\\circ-150^\\circ}{2}=15^\\circ$ a $\\angle DCB=15^\\circ$.','$\\angle ACB=120^\\circ+15^\\circ=135^\\circ$; body $A$, $C$, $E$ leží na jedné přímce, proto $\\varphi=\\angle ECB=180^\\circ-135^\\circ=45^\\circ$.','$\\alpha+\\beta+\\varphi=30^\\circ+15^\\circ+45^\\circ=90^\\circ$.'},
  'A) $90^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PID20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9I · úloha 13',
  new List<String>{'Obsah pravoúhlého trojúhelníku $ABC$ (pravý úhel při vrcholu $C$) je $96\\ \\mathrm{cm}^2$. Délka odvěsny $BC$ je $12\\ \\mathrm{cm}$ (viz obrázek).','Jaká je délka přepony $AB$?'},
  new List<String>{'A) menší než $15\\ \\mathrm{cm}$','B) $15\\ \\mathrm{cm}$','C) $18\\ \\mathrm{cm}$','D) $20\\ \\mathrm{cm}$','E) větší než $20\\ \\mathrm{cm}$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 132 99"><path d="M26 62C35 62 42 69 42 78" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M31 72C31 71 32 70 33 70C34 70 34 71 34 72C34 72 34 73 33 73C32 73 31 72 31 72Z" style="fill:#000000"/><path d="M26 79L26 14L120 79L26 79" style="fill:none;stroke:#000000;stroke-width:2"/><text x="20" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="122" y="93" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="20" y="93" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="7" y="52" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">12 cm</text></svg>',
  'obr.svg',
  'Pravoúhlý trojúhelník ABC s pravým úhlem při vrcholu C, odvěsna BC svislá o délce 12 cm.',
  '',
  new List<String>{'Z obsahu $\\frac{1}{2}\\cdot|BC|\\cdot|AC|=96$ plyne $\\frac{1}{2}\\cdot12\\cdot|AC|=96$, tedy $|AC|=16\\ \\mathrm{cm}$.','Přepona $|AB|=\\sqrt{12^2+16^2}=\\sqrt{144+256}=\\sqrt{400}=20\\ \\mathrm{cm}$.'},
  'D) $20\\ \\mathrm{cm}$',
  2, 3, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','vypocet','vyber','bez-kalkulacky'},
  'M9PID20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
