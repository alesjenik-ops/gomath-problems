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
  'Zelený E13 – úhel v kosočtverci',
  new List<String>{'Na obrázku je vyznačen kosočtverec a naznačen úhel o velikosti $150^\\circ$ (mezi prodloužením úhlopříčky a stranou kosočtverce).','Jak velký je úhel na obrázku označený symbolem „?".'},
  new List<String>{'A) $100^\\circ$','B) $110^\\circ$','C) $120^\\circ$','D) $150^\\circ$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 500" font-family="sans-serif"> <line x1="221" y1="490" x2="452" y2="80" stroke="#000" stroke-width="1.3" stroke-dasharray="6 5"/> <polygon points="400,170 247,262 250,440 403,348" fill="none" stroke="#000" stroke-width="2.5"/> <path d="M 420 135 A 42 42 0 0 1 366 191" fill="none" stroke="#000" stroke-width="1.2"/> <text x="352" y="150" font-size="20" font-weight="bold">150°</text> <path d="M 402 318 A 30 30 0 0 1 377 364" fill="none" stroke="#000" stroke-width="1.2"/> <text x="372" y="352" font-size="22" font-weight="bold">?</text> </svg>',
  'kosoctverec.svg',
  'Kosočtverec s vyznačenou úhlopříčkou; u horního vrcholu je mezi prodloužením úhlopříčky a stranou úhel 150°, u protějšího vrcholu je vnitřní úhel označený otazníkem.',
  'Schematický nákres k úloze 13',
  new List<String>{'Úhlopříčka půlí vrcholový úhel. Prodloužení úhlopříčky svírá se stranou úhel $150^\\circ$, takže úhlopříčka svírá se stranou $180^\\circ-150^\\circ=30^\\circ$; vrcholový úhel je $2\\cdot30^\\circ=60^\\circ$. Sousední vrcholový úhel kosočtverce (označený „?") je $180^\\circ-60^\\circ=120^\\circ$.'},
  'C) $120^\\circ$',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E14 – mezikruží a čtverec',
  new List<String>{'Na obrázku jsou dvě soustředné kružnice – vepsaná a opsaná čtverci o straně $8$ m.','Vypočtěte poměr obsahu plochy šedě podbarveného mezikruží a obsahu plochy bílého kruhu.'},
  new List<String>{'A) $2:1$','B) $3:2$','C) $1:1$','D) $2:3$','E) jiný poměr'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 420" font-family="sans-serif"> <circle cx="250" cy="190" r="141" fill="#c9c9c9" stroke="#000" stroke-width="2"/> <circle cx="250" cy="190" r="100" fill="#ffffff" stroke="#000" stroke-width="2"/> <rect x="150" y="90" width="200" height="200" fill="none" stroke="#000" stroke-width="1.3" stroke-dasharray="7 6"/> <line x1="150" y1="352" x2="350" y2="352" stroke="#000" stroke-width="1"/> <polygon points="150,352 158,348 158,356" fill="#000"/><polygon points="350,352 342,348 342,356" fill="#000"/> <text x="250" y="378" font-size="16" text-anchor="middle">8 metrů</text> </svg>',
  'mezikruzi.svg',
  'Čtverec o straně 8 m, do něhož je vepsána menší kružnice a jemuž je opsána větší kružnice; mezikruží mezi kružnicemi je šedé, vnitřní kruh bílý.',
  'Dvě soustředné kružnice čtverce',
  new List<String>{'Vepsaná kružnice má poloměr $r=\\frac{8}{2}=4$ m, opsaná $R=\\frac{8\\sqrt{2}}{2}=4\\sqrt{2}$ m. Mezikruží: $\\pi(R^2-r^2)=\\pi(32-16)=16\\pi$. Bílý kruh: $\\pi r^2=16\\pi$. Poměr $16\\pi:16\\pi=1:1$.'},
  'C) $1:1$',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E15 – procenta (přiřazování)',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V pravoúhlém trojúhelníku jsou velikosti vnitřních úhlů v poměru $3:2:1$. Prostřední úhel zvětšíme o třetinu. O jakou část musíme zmenšit nejmenší úhel, aby trojúhelník zůstal pravoúhlý?','15.2 V obdélníku zvětšíme jednu stranu o čtvrtinu. O jakou část musíme zmenšit druhou stranu, aby obsah obdélníku zůstal zachován?','15.3 V průběhu chemického pokusu klesá postupně a rovnoměrně objem lihu v baňce. Při prvním měření $4$ minuty po zahájení pokusu byl jeho objem o pětinu menší než při zahájení pokusu. O jakou část objemu zjištěného při prvním měření klesne objem lihu v baňce za dalších osm minut?'},
  new List<String>{'A) o $\\frac{3}{4}$','B) o $\\frac{2}{3}$','C) o $\\frac{1}{2}$','D) o $\\frac{1}{4}$','E) o $\\frac{1}{5}$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Úhly jsou $90^\\circ,60^\\circ,30^\\circ$. Prostřední zvětšíme o třetinu na $80^\\circ$ (o $20^\\circ$). Pravý úhel zůstává $90^\\circ$, takže nejmenší úhel je $180^\\circ-90^\\circ-80^\\circ=10^\\circ$; zmenšil se z $30^\\circ$ o $20^\\circ$, tj. o $\\frac{2}{3}$ → B.','15.2 Strana krát $\\frac{5}{4}$; druhou vynásobíme $\\frac{4}{5}$, tj. zmenšíme o $\\frac{1}{5}$ → E.','15.3 Rovnoměrný pokles $\\frac{1}{5}$ objemu za $4$ min. Za dalších $8$ min klesne o $2\\cdot\\frac{1}{5}=\\frac{2}{5}$ počátečního objemu. Vzhledem k prvnímu měření ($\\frac{4}{5}$ počátku) je to $\\frac{2/5}{4/5}=\\frac{1}{2}$ → C.'},
  '15.1: B (o $\\frac{2}{3}$); 15.2: E (o $\\frac{1}{5}$); 15.3: C (o $\\frac{1}{2}$)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
