String SRC   = 'CERMAT – Jednotná přijímací zkouška 2019, 1. řádný termín (M9A)';
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
  'CERMAT 2019 M9A · úloha 13',
  new List<String>{'Čtverec se stranou délky $17\\ \\mathrm{cm}$ je rozdělen na šedý šestiúhelník a dva shodné bílé trojúhelníky (viz obrázek). Nejdelší strana bílého trojúhelníku má délku $17\\ \\mathrm{cm}$. Nejkratší strana šedého šestiúhelníku měří $2\\ \\mathrm{cm}$.','Jaký je obsah šedého šestiúhelníku?'},
  new List<String>{'A) $127\\ \\mathrm{cm}^2$','B) $144\\ \\mathrm{cm}^2$','C) $169\\ \\mathrm{cm}^2$','D) $177\\ \\mathrm{cm}^2$','E) jiný obsah'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 133 125"><path d="M24 5L24 24L69 102L122 102L122 47L44 5L24 5Z" style="fill:#c7c9cb"/><path d="M44 4L122 46C122 47 122 47 122 47C122 48 122 48 121 48L43 6C43 5 43 5 43 4C43 4 44 4 44 4Z" style="fill:#231f20"/><path d="M24 24L69 102M24 5L122 5L122 102L24 102Z" style="fill:none;stroke:#231f20;stroke-width:2"/><text x="73" y="119" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">17 cm</text><text x="7" y="22" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2 cm</text><text x="99" y="26" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">17 cm</text></svg>',
  'obr.svg',
  'Čtverec o straně 17 cm rozdělený na šedý šestiúhelník a dva shodné bílé pravoúhlé trojúhelníky; nejdelší strany trojúhelníků měří 17 cm, nejkratší strana šestiúhelníku 2 cm.',
  '',
  new List<String>{'Každý bílý trojúhelník je pravoúhlý s přeponou $17\\ \\mathrm{cm}$; jeho odvěsny jsou $8\\ \\mathrm{cm}$ a $15\\ \\mathrm{cm}$, neboť $8^2+15^2=17^2$ a $17-15=2\\ \\mathrm{cm}$ je nejkratší strana šestiúhelníku.','Obsah jednoho bílého trojúhelníku je $\\frac{8\\cdot15}{2}=60\\ \\mathrm{cm}^2$, obou dohromady $120\\ \\mathrm{cm}^2$.','Obsah čtverce je $17^2=289\\ \\mathrm{cm}^2$, obsah šedého šestiúhelníku je $289-120=169\\ \\mathrm{cm}^2$.'},
  'C) $169\\ \\mathrm{cm}^2$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','vypocet','vyber','bez-kalkulacky'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 14',
  new List<String>{'Krychle byla slepena z $27$ malých bílých krychliček o hraně délky $2\\ \\mathrm{cm}$ (sestavených jako $3\\times3\\times3$). Z krychle jsme odstranili dvě malé krychličky a vzniklo tak nové těleso: jedna krychlička byla odebrána ze středu jedné stěny (uprostřed stěny) a jedna z hrany krychle (krychlička, která měla před odebráním na povrchu dvě stěny). Všechny dostupné plochy nového tělesa jsme obarvili na šedo (i zespodu).','Jaký je celkový obsah šedých ploch nového tělesa?'},
  new List<String>{'A) menší než $236\\ \\mathrm{cm}^2$','B) $236\\ \\mathrm{cm}^2$','C) $240\\ \\mathrm{cm}^2$','D) $244\\ \\mathrm{cm}^2$','E) větší než $244\\ \\mathrm{cm}^2$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Velká krychle má hranu $6\\ \\mathrm{cm}$ a povrch $6\\cdot6^2=216\\ \\mathrm{cm}^2$; obsah stěny malé krychličky je $2\\cdot2=4\\ \\mathrm{cm}^2$.','Odebráním krychličky ze středu stěny (měla $1$ stěnu na povrchu) ubude $1$ stěna a přibude $5$ nových stěn, tj. $+4$ stěny $=+16\\ \\mathrm{cm}^2$.','Odebráním krychličky z hrany (měla $2$ stěny na povrchu) ubudou $2$ stěny a přibudou $4$ nové stěny, tj. $+2$ stěny $=+8\\ \\mathrm{cm}^2$.','Celkem $216+16+8=240\\ \\mathrm{cm}^2$.'},
  'C) $240\\ \\mathrm{cm}^2$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','vypocet','vyber','bez-kalkulacky'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Cena jedné židle se snížila o $25\\ \\%$ na $1\\,800$ korun. Kolik korun stála jedna židle před snížením ceny?','15.2 Výrobek po zdražení o $20\\ \\%$ stojí $2\\,700$ korun. Kolik korun stál výrobek před zdražením?','15.3 Jana na lyžařské brýle přispěla $40\\ \\%$, chybějících $900$ korun za lyžařské brýle doplatil strýc. Cena za lyžařské brýle tvořila $60\\ \\%$ celé útraty za nákup lyžařských doplňků. Kolik korun činila celá útrata za nákup lyžařských doplňků?','Nabídka: A) $2\\,160$ korun; B) $2\\,250$ korun; C) $2\\,340$ korun; D) $2\\,400$ korun; E) $2\\,500$ korun; F) jiný počet korun.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $1\\,800$ je $75\\ \\%$ původní ceny; $1\\,800:0{,}75=2\\,400$ — \\textbf{D}.','15.2: $2\\,700$ je $120\\ \\%$ původní ceny; $2\\,700:1{,}2=2\\,250$ — \\textbf{B}.','15.3: chybějících $900$ korun je $60\\ \\%$ ceny brýlí, tedy brýle stály $900:0{,}6=1\\,500$ korun; brýle tvořily $60\\ \\%$ celé útraty, celá útrata $1\\,500:0{,}6=2\\,500$ korun — \\textbf{E}.'},
  '15.1: D; 15.2: B; 15.3: E',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PAD19C0T01', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
