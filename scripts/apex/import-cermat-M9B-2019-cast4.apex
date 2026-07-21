String SRC   = 'CERMAT – Jednotná přijímací zkouška 2019, 2. řádný termín (M9B)';
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
  'CERMAT 2019 M9B · úloha 12',
  new List<String>{'V trojúhelníku (viz obrázek) je vrcholový úhel rozdělen dvěma vnitřními úsečkami na tři shodné úhly $\\varphi$. Levá z těchto úseček je výška trojúhelníku (v patě svírá s podstavou pravý úhel). Pravá vnitřní úsečka svírá s podstavou (směrem doprava) úhel $116^\\circ$. Úhel při levém vrcholu podstavy je $\\alpha$, při pravém vrcholu $\\beta$.','Kolik je $\\alpha+\\beta$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $90^\\circ$','B) $92^\\circ$','C) $102^\\circ$','D) $112^\\circ$','E) jiný výsledek'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 487 98"><path d="M4 4L483 4L483 5L4 5Z" style="fill:#231f20"/><path d="M23 93L23 93L64 12C64 12 65 12 65 12C65 12 65 12 65 12L186 93C186 93 186 93 186 94C186 94 186 94 186 94L23 94C23 94 23 94 23 94C23 94 23 93 23 93L23 93L23 93L183 93L65 13L24 94L23 93L23 93L23 93Z" style="fill:#231f20"/><path d="M65 12L65 93" style="fill:none;stroke:#231f20;stroke-width:2"/><path d="M65 56C58 56 51 54 45 51M84 47C78 51 72 52 65 52M95 33C92 37 88 41 83 44M99 71C111 64 127 69 134 81C136 85 137 89 137 93M65 82C59 82 54 87 54 93M33 74C41 78 45 85 45 93M148 93C147 86 149 78 154 72" style="fill:none;stroke:#231f20;stroke-width:1"/><path d="M66 12L112 93C112 93 112 94 112 94C111 94 111 94 111 94L64 13C64 12 64 12 65 12C65 11 66 12 66 12Z" style="fill:#231f20"/><path d="M59 89C59 88 60 88 60 88C61 88 61 88 61 89C61 89 61 90 60 90C60 90 59 89 59 89Z" style="fill:#231f20"/><text x="85" y="38" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">φ</text><text x="73" y="47" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">φ</text><text x="57" y="49" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">φ</text><text x="35" y="91" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">α</text><text x="120" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">116°</text><text x="157" y="90" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">β</text></svg>',
  'obr.svg',
  'Trojúhelník s vrcholovým úhlem rozděleným na tři shodné úhly φ; levá vnitřní úsečka je výška (pravý úhel u paty), pravá svírá s podstavou úhel 116°; úhly α a β jsou při vrcholech podstavy.',
  '',
  new List<String>{'U paty pravé úsečky je $116^\\circ$, tedy vnitřní úhel v pravoúhlém trojúhelníku (výška–pravá úsečka) je $180^\\circ-116^\\circ=64^\\circ$, a proto $\\varphi=90^\\circ-64^\\circ=26^\\circ$.','Levý díl: v pravoúhlém trojúhelníku s výškou je $\\alpha=90^\\circ-\\varphi=90^\\circ-26^\\circ=64^\\circ$.','Pravý díl: v trojúhelníku s úhlem $116^\\circ$ a vrcholovým dílem $\\varphi=26^\\circ$ je $\\beta=180^\\circ-116^\\circ-26^\\circ=38^\\circ$.','$\\alpha+\\beta=64^\\circ+38^\\circ=102^\\circ$.'},
  'C) $102^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 13',
  new List<String>{'Rotační válec s podstavou o poloměru $5\\ \\mathrm{cm}$ stojící na vodorovné podložce jsme svislými řezy rozdělili na čtyři shodná nová tělesa. Povrch válce byl šedý (včetně podstav), ale všechny nové plochy vytvořené rozříznutím jsou bílé. Součet obsahů obou bílých ploch na jednom z nových těles je $80\\ \\mathrm{cm}^2$.','Jaký je objem jednoho z nových těles? Výsledek je zaokrouhlen na celé cm$^3$.'},
  new List<String>{'A) menší než $125\\ \\mathrm{cm}^3$','B) $126\\ \\mathrm{cm}^3$','C) $141\\ \\mathrm{cm}^3$','D) $157\\ \\mathrm{cm}^3$','E) větší než $158\\ \\mathrm{cm}^3$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Dvěma svislými řezy osou válce vznikne čtvrtina válce. Obě bílé plochy jsou obdélníky $r\\times v$, tedy $2\\cdot(5\\cdot v)=80\\Rightarrow10v=80\\Rightarrow v=8\\ \\mathrm{cm}$.','Objem jednoho tělesa (čtvrtina válce) $=\\frac{1}{4}\\pi r^2 v=\\frac{1}{4}\\pi\\cdot25\\cdot8=50\\pi\\doteq157\\ \\mathrm{cm}^3$.'},
  'D) $157\\ \\mathrm{cm}^3$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','vyber','bez-kalkulacky'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 14',
  new List<String>{'Kryštof, Lenka a Marek sbírali do čtvrtlitrových hrnků borůvky. Kryštof naplnil borůvkami třikrát více hrnků než Marek. Lenka naplnila borůvkami o $50\\ \\%$ méně hrnků než Kryštof. Kryštof naplnil borůvkami o $2$ hrnky více než Lenka s Markem dohromady.','Označme $m$ neznámý počet hrnků, které naplnil borůvkami Marek. Ze které z následujících rovnic lze v souladu se zadáním vypočítat $m$?'},
  new List<String>{'A) $3m=2{,}5m+2$','B) $3m+2=2{,}5m$','C) $3m-2=2m+0{,}5$','D) $3m=2{,}5m+2{,}5$','E) $3m-2=2m+50$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Kryštof $=3m$, Lenka $=0{,}5\\cdot3m=1{,}5m$. Podmínka „o $2$ více než Lenka a Marek dohromady“: $3m=1{,}5m+m+2$, tj. $3m=2{,}5m+2$.'},
  'A) $3m=2{,}5m+2$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','algebra','slovni','vyber','uvazovani','bez-kalkulacky'},
  'M9PBD19C0T02', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
