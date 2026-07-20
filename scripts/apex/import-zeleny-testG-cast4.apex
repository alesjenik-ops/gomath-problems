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
  'Zelený G11 – dvě trasy k jezeru (mapa a měřítko)',
  new List<String>{'Na mapě v měřítku $1:100\\,000$ vedou od nás k jezeru dvě trasy. Jedna měří $10$ cm, druhá o $2$ cm méně. Ve skutečnosti je to tak, že ať jdete jednou či druhou cestou, trvá vám to k jezeru dvě hodiny.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Jdete-li delší trasou, jdete o pětinu rychleji.','11.2 Půjdete-li od jezera jinou trasou než k němu, bude výlet k jezeru a zpět $18$ km dlouhý.','11.3 Na mapě $1:25\\,000$ budou ve srovnání s mapou v měřítku $1:100\\,000$ trasy o čtvrtinu delší.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <circle cx="55" cy="228" r="7" fill="#000000"/> <text x="55" y="255" font-size="15" text-anchor="middle" font-weight="bold">my</text> <ellipse cx="380" cy="80" rx="62" ry="38" fill="#cfe2f3" stroke="#2a6099" stroke-width="1.5"/> <text x="380" y="85" font-size="15" text-anchor="middle" fill="#1a3c5a">jezero</text> <path d="M 62 224 C 150 205 215 148 322 90" fill="none" stroke="#444444" stroke-width="2.2"/> <path d="M 62 232 C 130 300 305 250 352 114" fill="none" stroke="#444444" stroke-width="2.2" stroke-dasharray="7 5"/> <text x="168" y="146" font-size="14" fill="#333333">10 cm</text> <text x="232" y="258" font-size="14" fill="#333333">8 cm</text> </svg>',
  'trasy-jezero.svg',
  'Schematická mapka: od výchozího bodu vedou k jezeru dvě trasy, delší 10 cm a kratší 8 cm (v měřítku mapy).',
  'Schematický nákres dvou tras k jezeru',
  new List<String>{'Skutečné délky: $10$ cm $=10$ km, $8$ cm $=8$ km. Obě trvají $2$ h, tedy rychlosti $5$ km/h a $4$ km/h.','11.1 Delší trasou jdete $5$ km/h oproti $4$ km/h, tj. o čtvrtinu rychleji, ne o pětinu. Nepravdivé (Ne).','11.2 Tam jednou a zpět druhou trasou: $10+8=18$ km. Pravdivé (Ano).','11.3 Měřítko $1:25\\,000$ je $4$krát podrobnější, trasy jsou na mapě $4$krát delší, ne o čtvrtinu. Nepravdivé (Ne).'},
  '11.1: Ne; 11.2: Ano; 11.3: Ne',
  3, 6, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený G12 – obklad viaduktu (obsah)',
  new List<String>{'Na obrázku je betonové těleso viaduktu dlouhého $10$ m a širokého $8$ m. Výška viaduktu je $5$ metrů. V ose tělesa vede $4$ m široký a $4$ m vysoký průjezd (spodní část výšky $2$ m, nad ní půlkruhový oblouk). Vnitřek průjezdu i obě jeho čelní stěny jsou obloženy dlaždicemi.','Jaký je obsah plochy obložené dlaždicemi? Výsledek zaokrouhlete na celé m² ($\\pi=3{,}14$).'},
  new List<String>{'A) $95$ m²','B) $114$ m²','C) $154$ m²','D) $209$ m²','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif"> <polygon points="90,180 330,180 460,115 220,115" fill="#dcdcdc" stroke="#000000" stroke-width="2"/> <polygon points="330,180 460,115 460,265 330,330" fill="#c4c4c4" stroke="#000000" stroke-width="2"/> <polygon points="90,180 330,180 330,330 90,330" fill="#eeeeee" stroke="#000000" stroke-width="2"/> <path d="M 150 330 L 150 270 A 60 60 0 0 1 270 270 L 270 330 Z" fill="#ffffff" stroke="#000000" stroke-width="2"/> <path d="M 210 210 L 340 145" fill="none" stroke="#000000" stroke-width="1" stroke-dasharray="5 4"/> <line x1="62" y1="180" x2="62" y2="330" stroke="#000000" stroke-width="1"/> <text x="52" y="258" font-size="15" text-anchor="middle" transform="rotate(-90 52 258)">5 m</text> <text x="126" y="306" font-size="14" text-anchor="middle">2 m</text> <text x="292" y="278" font-size="14" text-anchor="middle" transform="rotate(-90 292 278)">4 m</text> <text x="120" y="352" font-size="14" text-anchor="middle">2 m</text> <text x="210" y="352" font-size="14" text-anchor="middle">4 m</text> <text x="300" y="352" font-size="14" text-anchor="middle">2 m</text> <text x="408" y="212" font-size="15" text-anchor="middle" transform="rotate(-27 408 212)">10 m</text> </svg>',
  'viadukt.svg',
  'Betonový viadukt 10 m dlouhý, 8 m široký, 5 m vysoký s průjezdem 4 m širokým a 4 m vysokým (obdélník 2 m a půlkruhový oblouk o poloměru 2 m).',
  'Viadukt s klenutým průjezdem',
  new List<String>{'Průřez průjezdu: obdélník $4\\times 2$ m a půlkruh o poloměru $2$ m, obsah $8+\\frac{1}{2}\\pi\\cdot 2^2=8+6{,}28=14{,}28$ m².','Vnitřek průjezdu (dvě boční stěny po $2$ m a půlkruhový oblouk délky $\\pi\\cdot 2=6{,}28$ m) má obsah $(2+2+6{,}28)\\cdot 10=102{,}8$ m².','Dvě čelní stěny: $2\\cdot(8\\cdot 5-14{,}28)=2\\cdot 25{,}72=51{,}44$ m². Celkem $102{,}8+51{,}44=154{,}24\\doteq 154$ m².'},
  'C) $154$ m²',
  2, 7, '4',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
