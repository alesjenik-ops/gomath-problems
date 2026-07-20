String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený F13 – úhly ručiček hodin',
  new List<String>{'Na obrázku jsou hodiny.','Jak velké úhly mezi sebou svírají minutová a hodinová ručička hodin v momentě, kdy ukazují za pět minut tři čtvrtě na jedenáct?'},
  new List<String>{'A) 60° a 120°','B) 80° a 100°','C) 80° a 280°','D) 82° a 278°','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" font-family="sans-serif"> <circle cx="200" cy="200" r="150" fill="#ffffff" stroke="#000" stroke-width="4"/> <text x="200" y="81" font-size="20" text-anchor="middle">12</text> <text x="262" y="98" font-size="20" text-anchor="middle">1</text> <text x="308" y="144" font-size="20" text-anchor="middle">2</text> <text x="325" y="206" font-size="20" text-anchor="middle">3</text> <text x="308" y="268" font-size="20" text-anchor="middle">4</text> <text x="262" y="314" font-size="20" text-anchor="middle">5</text> <text x="200" y="331" font-size="20" text-anchor="middle">6</text> <text x="138" y="314" font-size="20" text-anchor="middle">7</text> <text x="92" y="268" font-size="20" text-anchor="middle">8</text> <text x="75" y="206" font-size="20" text-anchor="middle">9</text> <text x="92" y="144" font-size="20" text-anchor="middle">10</text> <text x="138" y="98" font-size="20" text-anchor="middle">11</text> <line x1="200" y1="200" x2="145" y2="135" stroke="#000" stroke-width="7" stroke-linecap="round"/> <line x1="200" y1="200" x2="96" y2="260" stroke="#000" stroke-width="4" stroke-linecap="round"/> <circle cx="200" cy="200" r="7" fill="#000"/> </svg>',
  'hodiny.svg',
  'Ciferník hodin s minutovou ručičkou u osmičky a hodinovou ručičkou mezi desítkou a jedenáctkou.',
  'Schematický nákres hodin',
  new List<String>{'„Za pět minut tři čtvrtě na jedenáct" je čas $10{:}40$. Minutová ručička ukazuje na osmičku, tj. $40\\cdot 6^\\circ = 240^\\circ$ od dvanáctky. Hodinová ručička odpovídá $10$ h $40$ min, tj. $10\\cdot 30^\\circ + 40\\cdot 0{,}5^\\circ = 320^\\circ$. Menší úhel je $320^\\circ - 240^\\circ = 80^\\circ$, druhý $360^\\circ - 80^\\circ = 280^\\circ$.'},
  'C) 80° a 280°',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený F14 – pobití štítu prkny',
  new List<String>{'Výška štítu stodoly, vyznačeného na obrázku šedým podkresem, je $5$ metrů a jeho šířka $10$ metrů. Štít je pobit prkny o tloušťce $25$ mm.','Kolika m³ prken byl pobit štít?'},
  new List<String>{'A) 0,625 m³','B) 0,750 m³','C) 1,350 m³','D) 0,925 m³','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 400" font-family="sans-serif"> <polygon points="260,110 110,250 410,250" fill="#c9c9c9" stroke="#000" stroke-width="2.5"/> <line x1="130" y1="250" x2="130" y2="231" stroke="#000" stroke-width="1"/> <line x1="155" y1="250" x2="155" y2="208" stroke="#000" stroke-width="1"/> <line x1="180" y1="250" x2="180" y2="185" stroke="#000" stroke-width="1"/> <line x1="205" y1="250" x2="205" y2="161" stroke="#000" stroke-width="1"/> <line x1="230" y1="250" x2="230" y2="138" stroke="#000" stroke-width="1"/> <line x1="255" y1="250" x2="255" y2="115" stroke="#000" stroke-width="1"/> <line x1="280" y1="250" x2="280" y2="129" stroke="#000" stroke-width="1"/> <line x1="305" y1="250" x2="305" y2="152" stroke="#000" stroke-width="1"/> <line x1="330" y1="250" x2="330" y2="175" stroke="#000" stroke-width="1"/> <line x1="355" y1="250" x2="355" y2="199" stroke="#000" stroke-width="1"/> <line x1="380" y1="250" x2="380" y2="222" stroke="#000" stroke-width="1"/> <rect x="110" y="250" width="300" height="110" fill="#ffffff" stroke="#000" stroke-width="2.5"/> <line x1="440" y1="110" x2="440" y2="250" stroke="#000" stroke-width="1.5"/> <polygon points="436,120 444,120 440,110" fill="#000"/> <polygon points="436,240 444,240 440,250" fill="#000"/> <text x="452" y="186" font-size="18">5 m</text> <line x1="110" y1="382" x2="410" y2="382" stroke="#000" stroke-width="1.5"/> <polygon points="120,378 120,386 110,382" fill="#000"/> <polygon points="400,378 400,386 410,382" fill="#000"/> <text x="243" y="376" font-size="18">10 m</text> </svg>',
  'stit-stodoly.svg',
  'Štít stodoly tvaru trojúhelníku o výšce 5 m a šířce 10 m nad obdélníkovou stěnou, plocha štítu je vyšrafována svislými prkny.',
  'Štít stodoly',
  new List<String>{'Štít je trojúhelník o obsahu $S = \\frac{1}{2}\\cdot 10\\cdot 5 = 25$ m². Tloušťka prken je $25$ mm $= 0{,}025$ m. Objem prken $V = 25\\cdot 0{,}025 = 0{,}625$ m³.'},
  'A) 0,625 m³',
  2, 4, '2',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
