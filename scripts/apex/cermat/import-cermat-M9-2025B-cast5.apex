String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD25C0T02';
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
  'CERMAT M9B 2025 - uloha 12',
  new List<String>{'V rovine lezi dva shodne rovnoramenne trojuhelniky a primka $p$ rovnobezna se zakladnou jednoho z nich. Druhy trojuhelnik ma prave jedno rameno rovnobezne s ramenem prvniho trojuhelniku. Uhel pri hlavnim vrcholu prvniho trojuhelniku ma velikost $40^\\circ$ (viz obrazek).','Jaka je velikost uhlu $\\alpha$? Velikosti uhlu nemerte, ale vypoctete (obrazek je pouze ilustrativni).'},
  new List<String>{'A) $160^\\circ$','B) $140^\\circ$','C) $130^\\circ$','D) $110^\\circ$','E) jina velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 190" font-family="sans-serif"> <line x1="20" y1="150" x2="440" y2="150" stroke="#000" stroke-width="1.5"/> <text x="446" y="155" font-size="14" font-style="italic">p</text> <polygon points="60,150 180,150 120,55" fill="none" stroke="#000" stroke-width="2"/> <text x="120" y="74" font-size="12" text-anchor="middle">40 st.</text> <polygon points="300,150 250,62 362,96" fill="none" stroke="#000" stroke-width="2"/> <text x="286" y="143" font-size="14">a</text> </svg>',
  'trojuhelniky-p.svg',
  'Dva shodne rovnoramenne trojuhelniky a vodorovna primka p; u prvniho vyznacen uhel 40 stupnu, u druheho uhel alfa.',
  'Ilustrativni obrazek k uloze 12',
  new List<String>{'Uhly pri zakladne rovnoramenneho trojuhelniku jsou $\\frac{180^\\circ-40^\\circ}{2}=70^\\circ$. Rameno druheho trojuhelniku je rovnobezne s ramenem prvniho, ktere svira se zakladnou (a tedy s primkou $p$) uhel $70^\\circ$. Uhel $\\alpha$ pri vrcholu druheho trojuhelniku na primce $p$ je rozdelen tuto rovnobezkou na dva uhly o velikosti $70^\\circ$, takze $\\alpha=70^\\circ+70^\\circ=140^\\circ$.'},
  'B) $140^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2025 - uloha 13',
  new List<String>{'Ze shodnych bilych a sedych krychlicek byla sestavena krychle tak, ze v kazde rade i v kazdem sloupci jsou 4 krychlicky. Sede krychlicky byly umisteny vzdy podel jedne ze dvou uhlopricek kazde steny krychle (viz obrazek). Vsechny zbyvajici krychlicky v krychli jsou bile.','Jaky je pocet vsech bilych krychlicek v krychli?'},
  new List<String>{'A) mene nez 36','B) 36','C) 48','D) 54','E) 72'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 260" font-family="sans-serif"><rect x="40" y="70" width="40" height="40" fill="#b7b7b7" stroke="#000"/><rect x="80" y="110" width="40" height="40" fill="#b7b7b7" stroke="#000"/><rect x="120" y="150" width="40" height="40" fill="#b7b7b7" stroke="#000"/><rect x="160" y="190" width="40" height="40" fill="#b7b7b7" stroke="#000"/><line x1="40" y1="70" x2="40" y2="230" stroke="#000"/><line x1="40" y1="70" x2="200" y2="70" stroke="#000"/><line x1="80" y1="70" x2="80" y2="230" stroke="#000"/><line x1="40" y1="110" x2="200" y2="110" stroke="#000"/><line x1="120" y1="70" x2="120" y2="230" stroke="#000"/><line x1="40" y1="150" x2="200" y2="150" stroke="#000"/><line x1="160" y1="70" x2="160" y2="230" stroke="#000"/><line x1="40" y1="190" x2="200" y2="190" stroke="#000"/><line x1="200" y1="70" x2="200" y2="230" stroke="#000"/><line x1="40" y1="230" x2="200" y2="230" stroke="#000"/><path d="M 40 70 L 95 35 L 255 35 L 200 70 Z" fill="none" stroke="#000"/><path d="M 200 70 L 255 35 L 255 195 L 200 230 Z" fill="none" stroke="#000"/><text x="180" y="248" font-size="11" text-anchor="middle" fill="#555">Schematicky nakres krychle 4 krat 4 krat 4 (sede na uhlopprickach sten).</text></svg>',
  'krychle.svg',
  'Schematicky nakres krychle slozene ze 4 krat 4 krat 4 krychlicek se sedymi krychlickami na uhlopricce steny.',
  'Schematicky nakres (prostorove teleso dle testoveho sesitu)',
  new List<String>{'Krychle ma $4\\cdot 4\\cdot 4=64$ krychlicek. Sede lezi na uhlopricce kazde ze 6 sten, po 4 na stenu. Dve vnitrni krychlicky kazde stenove uhlopricky patri jen jedne stene: $2\\cdot 6=12$ sedych. Krajni krychlicky uhlopricek jsou rohove krychlicky krychle; pri danem rozmisteni jsou to 4 rohy (kazdy sdileny tremi stenami). Celkem sedych $12+4=16$, takze bilych $64-16=48$.'},
  'C) $48$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
