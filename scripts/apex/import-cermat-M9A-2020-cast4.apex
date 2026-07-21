String SRC   = 'CERMAT – Jednotná přijímací zkouška 2020, řádný termín (M9A)';
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
  'CERMAT 2020 M9A · úloha 12',
  new List<String>{'Na obrázku jsou dvě rovnoběžné přímky (označené dvojitými ryskami) a tři příčky, které mezi nimi vytvářejí lomenou čáru. Jsou vyznačeny úhly $32^\\circ$, $62^\\circ$, $128^\\circ$ a hledaný úhel $\\alpha$ (viz obrázek).','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $98^\\circ$','B) $98^\\circ$','C) $100^\\circ$','D) $102^\\circ$','E) větší než $102^\\circ$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 249 93"><path d="M54 48C64 45 73 46 82 49M120 28C112 36 100 39 89 34M231 4L228 12M233 4L230 12M158 67C165 60 176 58 185 62C195 66 201 75 201 85M47 26C41 28 35 27 30 23C25 20 22 14 22 8M232 81L229 89M234 81L231 89" style="fill:none;stroke:#231f20;stroke-width:1"/><path d="M4 8L245 8M4 85L245 85M41 8L67 85M101 8L67 85M101 8L176 85" style="fill:none;stroke:#231f20;stroke-width:2"/><text x="35" y="22" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ߙ</text><text x="179" y="79" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">128</text><text x="190" y="79" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ι</text><text x="102" y="33" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">62</text><text x="111" y="33" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ι</text><text x="67" y="61" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">32</text><text x="75" y="61" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ι</text></svg>',
  'obr.svg',
  'Dvě rovnoběžné přímky a tři příčky tvořící lomenou čáru; vyznačené úhly 32°, 62°, 128° a hledaný úhel alfa.',
  '',
  new List<String>{'Přímky jsou rovnoběžné, využijeme střídavé (a vedlejší) úhly.','Z úhlu $128^\\circ$ u dolní přímky: pravá příčka svírá s dolní přímkou úhel $180^\\circ-128^\\circ=52^\\circ$, který se u horního vrcholu přenese jako střídavý úhel.','U horního vrcholu je $52^\\circ+62^\\circ=114^\\circ$, takže levé rameno svírá s vodorovnou přímkou úhel $180^\\circ-114^\\circ=66^\\circ$ (a stejně $66^\\circ$ i s dolní přímkou).','U dolního vrcholu přičteme úhel $32^\\circ$: příčka příslušná úhlu $\\alpha$ svírá s dolní přímkou $66^\\circ+32^\\circ=98^\\circ$. Podle střídavých úhlů je $\\alpha=98^\\circ$.'},
  'B) $98^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PAD20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9A · úloha 13',
  new List<String>{'Podstavou kolmého trojbokého hranolu $ABCDEF$ je pravoúhlý trojúhelník s odvěsnami délek $a=9\\ \\mathrm{cm}$ a $b=12\\ \\mathrm{cm}$ (viz obrázek). Obsah největší boční stěny $ABED$ je $300\\ \\mathrm{cm}^2$.','Jaký je povrch hranolu?'},
  new List<String>{'A) $828\\ \\mathrm{cm}^2$','B) $888\\ \\mathrm{cm}^2$','C) $936\\ \\mathrm{cm}^2$','D) $1\\,008\\ \\mathrm{cm}^2$','E) $1\\,080\\ \\mathrm{cm}^2$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 130 168"><path d="M11 147L95 128L113 147M11 33L95 15L113 33L11 33M11 33L11 147M113 33L113 147M95 128L95 15M11 147L113 147" style="fill:none;stroke:#231f20;stroke-width:2"/><path d="M88 134C88 133 89 132 90 132C91 132 91 133 91 133C92 134 91 135 90 135C89 135 88 134 88 134Z" style="fill:#231f20"/><path d="M103 136C92 139 80 138 75 133C75 133 75 133 75 133M102 23C99 24 95 24 92 24C84 24 77 22 75 19" style="fill:none;stroke:#231f20;stroke-width:1"/><path d="M88 20C88 20 89 19 90 19C91 19 91 19 91 20C92 21 91 21 90 21C89 22 88 21 88 20Z" style="fill:#231f20"/><text x="97" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">F</text><text x="120" y="32" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text><text x="7" y="32" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="87" y="126" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="118" y="162" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="7" y="162" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="106" y="134" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ܽ</text><text x="54" y="134" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ܾ</text></svg>',
  'obr.svg',
  'Kolmý trojboký hranol ABCDEF s podstavou pravoúhlého trojúhelníku (odvěsny a, b) a vyznačenými pravými úhly.',
  '',
  new List<String>{'Přepona podstavy $=\\sqrt{9^2+12^2}=\\sqrt{225}=15\\ \\mathrm{cm}$; největší boční stěna přísluší nejdelší hraně (přeponě) $15\\ \\mathrm{cm}$, tedy $15\\cdot v=300\\Rightarrow v=20\\ \\mathrm{cm}$ (výška hranolu).','Obsah podstavy $=\\frac{1}{2}\\cdot9\\cdot12=54\\ \\mathrm{cm}^2$; obě podstavy $108\\ \\mathrm{cm}^2$.','Plášť $=$ obvod podstavy $\\cdot\\,v=(9+12+15)\\cdot20=720\\ \\mathrm{cm}^2$.','Povrch $=108+720=828\\ \\mathrm{cm}^2$.'},
  'A) $828\\ \\mathrm{cm}^2$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','vypocet','vyber','bez-kalkulacky'},
  'M9PAD20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
