String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 2. řádný termín (M9B)';
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
  'CERMAT 2024 M9B · úloha 13',
  new List<String>{'Přímky $k$, $l$, $m$ leží v rovině; průsečíky přímek $k$, $l$, $m$ tvoří vrcholy trojúhelníku $ABC$. Bodem $B$ prochází také přímka $n$. Jsou vyznačeny úhly $125^\\circ$ (u $C$), $105^\\circ$ (u $A$) a $90^\\circ$ (u $B$) (viz obrázek).','Jaká je velikost úhlu $\\alpha$? (Velikosti neměřte, ale vypočítejte.)'},
  new List<String>{'A) $55^\\circ$','B) $50^\\circ$','C) $45^\\circ$','D) $40^\\circ$','E) $35^\\circ$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 462 254"><path d="M4 4L5 4L5 249L4 249Z" style="fill:#231f20"/><path d="M4 249L5 249L5 250L4 250Z" style="fill:#231f20"/><path d="M4 249L5 249L5 250L4 250Z" style="fill:#231f20"/><path d="M5 249L456 249L456 250L5 250Z" style="fill:#231f20"/><path d="M456 4L458 4L458 249L456 249Z" style="fill:#231f20"/><path d="M456 249L458 249L458 250L456 250Z" style="fill:#231f20"/><path d="M456 249L458 249L458 250L456 250Z" style="fill:#231f20"/><path d="M86 205L365 158M150 73L357 197M192 60L129 239M296 66L315 228M305 141C320 138 334 148 336 163C336 163 336 163 336 163M119 200C116 185 125 171 139 168C144 167 149 167 154 169M172 117C158 113 151 97 156 83C156 81 157 80 158 78M277 150C283 140 293 134 304 133" style="fill:none;stroke:#231f20;stroke-width:1"/></svg>',
  'obr.svg',
  'Přímky k, l, m tvořící trojúhelník ABC a přímka n bodem B; vyznačené úhly 125°, 105° a 90°.',
  '',
  new List<String>{'Vnitřní úhly: při $C$ $180^\\circ-125^\\circ=55^\\circ$, při $A$ $180^\\circ-105^\\circ=75^\\circ$, při $B$ $180^\\circ-55^\\circ-75^\\circ=50^\\circ$.','Úhel $\\alpha=90^\\circ-50^\\circ=40^\\circ$.'},
  'D) $40^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD24C0T02', 2024
);
c.add(
  'CERMAT 2024 M9B · úloha 14',
  new List<String>{'Ve čtvercové síti (strana čtverce $2\\ \\mathrm{cm}$) je zakreslen šedý obrazec — půlkruh s průměrem $AB$, kde $A$, $B$ leží v mřížových bodech a $|AB|=8\\ \\mathrm{cm}$ (viz obrázek).','Jaký je obsah šedé části? (Použijte $\\pi\\doteq3{,}14$.)'},
  new List<String>{'A) $20{,}28\\ \\mathrm{cm}^2$','B) $22{,}56\\ \\mathrm{cm}^2$','C) $24{,}56\\ \\mathrm{cm}^2$','D) $25{,}12\\ \\mathrm{cm}^2$','E) $30{,}24\\ \\mathrm{cm}^2$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Průměr $AB=8\\ \\mathrm{cm}$, poloměr $4\\ \\mathrm{cm}$; obsah půlkruhu $\\frac{1}{2}\\pi\\cdot4^2=\\frac{1}{2}\\cdot3{,}14\\cdot16=25{,}12\\ \\mathrm{cm}^2$.'},
  'D) $25{,}12\\ \\mathrm{cm}^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD24C0T02', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
