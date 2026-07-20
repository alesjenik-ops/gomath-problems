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
  'Zelený K8 – šesticípá hvězda',
  new List<String>{'Na obrázku je pravidelná šesticípá hvězda. Vzdálenost mezi protilehlými vrcholy hvězdy je $8$ cm, její šířka je $7$ cm. Trojúhelník s šedým podkresem (jeden cíp) je rovnostranný o výšce $2$ cm.','8.1 Vypočtěte obvod šesticípé hvězdy.','8.2 Vypočtěte obsah šesticípé hvězdy.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif"> <polygon points="250,80 215,140 146,140 181,200 146,260 215,260 250,320 285,260 354,260 319,200 354,140 285,140" fill="none" stroke="#000" stroke-width="2.5"/> <polygon points="250,80 215,140 285,140" fill="#c9c9c9" stroke="#000" stroke-width="2"/> <line x1="146" y1="45" x2="354" y2="45" stroke="#444" stroke-width="1"/> <polygon points="146,45 154,41 154,49" fill="#444"/><polygon points="354,45 346,41 346,49" fill="#444"/> <text x="250" y="38" font-size="16" text-anchor="middle">7 cm</text> <line x1="420" y1="80" x2="420" y2="320" stroke="#444" stroke-width="1"/> <polygon points="420,80 416,88 424,88" fill="#444"/><polygon points="420,320 416,312 424,312" fill="#444"/> <text x="440" y="205" font-size="16" text-anchor="middle" transform="rotate(-90 440 205)">8 cm</text> <line x1="200" y1="80" x2="200" y2="140" stroke="#444" stroke-width="1"/> <polygon points="200,80 196,88 204,88" fill="#444"/><polygon points="200,140 196,132 204,132" fill="#444"/> <text x="182" y="112" font-size="14" text-anchor="middle" transform="rotate(-90 182 112)">2 cm</text> </svg>',
  'hvezda.svg',
  'Pravidelná šesticípá hvězda; vzdálenost protilehlých vrcholů 8 cm, šířka 7 cm, jeden cíp je rovnostranný trojúhelník o výšce 2 cm.',
  'Pravidelná šesticípá hvězda',
  new List<String>{'Vzdálenost protilehlých vrcholů je $8$ cm, poloměr k vrcholům je $R=4$ cm. Výška cípu je $2$ cm, takže vzdálenost středu od strany vnitřního šestiúhelníku je $4-2=2$ cm. Strana cípu (i šestiúhelníku) $a$ splňuje $\\frac{a\\sqrt{3}}{2}=2$, tedy $a=\\frac{4}{\\sqrt{3}}\\doteq 2{,}31$ cm.','8.1 Hvězda má $12$ stejných stran délky $a$: obvod $=12a=\\frac{48}{\\sqrt{3}}=16\\sqrt{3}\\doteq 28$ cm.','8.2 Hvězda se skládá z $12$ shodných rovnostranných trojúhelníků (vnitřní šestiúhelník $=6$ a $6$ cípů), každý o obsahu $\\frac{1}{2}\\cdot a\\cdot 2=a$. Obsah $=12a=16\\sqrt{3}\\doteq 28$ cm².'},
  '8.1: $28$ cm; 8.2: $28$ cm²',
  4, 8, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K9 – množina vrcholů C (AC = 2 BC)',
  new List<String>{'Na přímce $p$ leží úsečka $AB$ o délce $6$ cm.','Vyznačte množinu vrcholů $C$ trojúhelníků $ABC$, pro které platí, že délka strany $AC$ je dvojnásobkem délky strany $BC$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 230" font-family="sans-serif"> <line x1="40" y1="150" x2="460" y2="150" stroke="#000" stroke-width="2"/> <text x="472" y="155" font-size="16" font-style="italic">p</text> <line x1="150" y1="140" x2="150" y2="160" stroke="#000" stroke-width="2"/> <line x1="350" y1="140" x2="350" y2="160" stroke="#000" stroke-width="2"/> <text x="150" y="182" font-size="16" text-anchor="middle" font-weight="bold">A</text> <text x="350" y="182" font-size="16" text-anchor="middle" font-weight="bold">B</text> <line x1="150" y1="120" x2="350" y2="120" stroke="#444" stroke-width="1"/> <polygon points="150,120 158,116 158,124" fill="#444"/><polygon points="350,120 342,116 342,124" fill="#444"/> <text x="250" y="112" font-size="15" text-anchor="middle">6 cm</text> </svg>',
  'usecka-ab.svg',
  'Vodorovná přímka p s vyznačenou úsečkou AB o délce 6 cm.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Bod $C$, pro který $|AC|=2|BC|$, leží na Apollóniově kružnici. Na přímce $p$ jsou dva takové body: vnitřní bod $N$ ($|AN|=4$ cm, $|NB|=2$ cm) a vnější bod $M$ ($|AM|=12$ cm, $|MB|=6$ cm). Úsečka $NM$ je průměr hledané kružnice, její střed $S$ je střed $NM$ a poloměr $|SN|=|SM|=4$ cm. Body $N$ a $M$ vyloučíme (leží na přímce $p$, netvoří trojúhelník).'},
  'Množina bodů $C$ je kružnice $k$ se středem $S$ a poloměrem $4$ cm s výjimkou průsečíků přímky $p$ a kružnice $k$ (bodů $N$ a $M$).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
