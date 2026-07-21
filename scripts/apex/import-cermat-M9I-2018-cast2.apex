String SRC   = 'CERMAT – Ilustrační test 2018, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2018 M9I · úloha 7',
  new List<String>{'Obdélník $ABCD$ lze rozdělit na šest shodných pravoúhlých trojúhelníků. Přemístěním jediného trojúhelníku lze vytvořit lichoběžník $EFGH$ (viz obrázek). Strana trojúhelníku délky $8\\ \\mathrm{cm}$ je současně výškou lichoběžníku. Rameno lichoběžníku měří $10\\ \\mathrm{cm}$.','7.1 Určete, o kolik cm se liší obvod lichoběžníku $EFGH$ a obvod obdélníku $ABCD$.','7.2 Vypočtěte v cm délku strany $AB$ obdélníku $ABCD$.','7.3 Vypočtěte v cm$^2$ obsah lichoběžníku $EFGH$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 102"><path d="M314 13L314 64L352 13Z" style="fill:#b6b8bc"/><path d="M11 61L36 61L36 83L11 83Z" style="fill:#ffffff"/><path d="M25 64L25 14L62 64Z" style="fill:#b6b8bc"/><path d="M236 12L276 12L276 65L236 65ZM238 64L237 64L275 64L274 64L274 13L275 13L237 13L238 13Z" style="fill:#000000"/><path d="M313 64L314 64L314 13L314 13L352 13L351 12L313 64M352 13C353 13 353 12 353 12C352 12 352 12 352 12L314 12C313 12 313 12 313 13L313 64C313 65 313 65 313 65C314 65 314 65 314 65Z" style="fill:#000000"/><path d="M237 13L237 13L237 64L237 64Z" style="fill:#ce60a4"/><path d="M237 64L275 64L275 65L237 65Z" style="fill:#ce60a4"/><path d="M236 13L238 13L238 64L237 64L275 64L274 65L236 13M276 64C276 64 276 64 276 65C276 65 275 65 275 65L237 65C236 65 236 65 236 64L236 13C236 12 236 12 237 12C237 12 237 12 237 12Z" style="fill:#000000"/><path d="M274 12L314 12L314 65L274 65ZM276 64L275 64L313 64L313 64L313 13L313 13L275 13L276 13Z" style="fill:#000000"/><path d="M275 64L314 64L314 65L275 65Z" style="fill:#ce60a4"/><path d="M275 13L276 13L276 64L275 64L314 64L313 65L275 13M314 64C315 64 315 64 314 65C314 65 314 65 314 65L275 65C275 65 275 65 275 64L275 13C275 12 275 12 275 12C275 12 276 12 276 12Z" style="fill:#000000"/><path d="M237 64L236 64L236 13L237 13L198 13L199 12L237 64M198 13C198 13 198 12 198 12C198 12 198 12 198 12L237 12C237 12 238 12 238 13L238 64C238 65 237 65 237 65C237 65 236 65 236 65Z" style="fill:#000000"/><path d="M62 12L103 12L103 65L62 65ZM64 65L63 64L102 64L101 65L101 13L102 14L63 14L64 13Z" style="fill:#000000"/><path d="M24 13L25 13L25 65L24 64L63 64L62 65L24 13M64 64C64 64 64 65 64 65C64 65 63 65 63 65L24 65C24 65 24 65 24 65L24 13C24 13 24 12 24 12C25 12 25 12 25 12Z" style="fill:#000000"/><path d="M24 12L64 12L64 65L24 65ZM25 65L24 64L63 64L62 65L62 13L63 14L24 14L25 13Z" style="fill:#000000"/><path d="M63 13L63 13L63 65L63 65Z" style="fill:#ce60a4"/><path d="M63 64L102 64L102 65L63 65Z" style="fill:#ce60a4"/><path d="M62 13L64 13L64 65L63 64L102 64L101 65L62 13M102 64C103 64 103 65 102 65C102 65 102 65 102 65L63 65C63 65 62 65 62 65L62 13C62 13 63 12 63 12C63 12 64 12 64 12Z" style="fill:#000000"/><path d="M101 12L141 12L141 65L101 65ZM102 65L102 64L140 64L140 65L140 13L140 14L102 14L102 13Z" style="fill:#000000"/><path d="M102 64L140 64L140 65L102 65Z" style="fill:#ce60a4"/><path d="M101 13L102 13L102 65L101 64L140 64L139 65L101 13M140 64C141 64 141 65 141 65C140 65 140 65 140 65L101 65C101 65 100 65 100 65L100 13C100 13 101 12 101 12C101 12 102 12 102 12Z" style="fill:#000000"/><path d="M154 50L154 50L155 52L156 54L157 56L157 58L157 59L157 61L157 63L157 65L157 66L156 68L156 70L155 72L154 73L153 75L152 76L150 80L148 81L146 83L145 84L143 85L141 87L139 88L137 89L135 90L132 91L130 92L127 93L125 94L119 95L116 96L111 97L108 97L105 98L102 98L96 98L90 97L88 97L85 97L79 96L77 95L74 95L71 94L69 93L67 92L64 91L62 90L60 89L58 88L55 87L54 85L52 84L48 81L47 80L45 78L44 76L43 75L42 73L41 71L40 69L40 67L41 67L42 69L42 70L43 72L44 74L45 75L48 79L49 80L51 82L56 85L58 87L60 88L62 89L65 90L67 91L69 92L77 94L80 94L82 95L85 95L88 96L90 96L93 96L96 96L99 96L102 96L105 96L107 96L110 95L113 95L116 95L119 94L122 93L124 93L127 92L129 91L132 90L134 89L136 88L138 87L140 85L142 84L144 83L145 81L147 80L148 79L150 77L152 74L153 73L154 71L154 69L155 68L155 66L156 64L156 63L156 61L156 59L156 58L155 56L155 54L154 53L153 51L153 51L154 50M153 57L153 49L160 53C160 53 160 54 160 54C160 54 160 55 159 54L153 51L154 50L154 57C154 58 154 58 154 58C153 58 153 58 153 57Z" style="fill:#7b7e82"/></svg>',
  'obr.svg',
  'Obdélník ABCD rozdělený na šest shodných pravoúhlých trojúhelníků a lichoběžník EFGH vytvořený přemístěním jednoho z nich; jeden trojúhelník je zvýrazněn.',
  '',
  new List<String>{'Pravoúhlý trojúhelník má odvěsny $8\\ \\mathrm{cm}$ a $6\\ \\mathrm{cm}$ (neboť $\\sqrt{10^2-8^2}=\\sqrt{36}=6$) a přeponu (rameno) $10\\ \\mathrm{cm}$.','7.2: obdélník tvoří tři sloupce po $6\\ \\mathrm{cm}$, tedy $AB=3\\cdot6=18\\ \\mathrm{cm}$ (výška je $8\\ \\mathrm{cm}$).','7.3: přemístěním trojúhelníku se obsah nemění, $S=18\\cdot8=144\\ \\mathrm{cm}^2$.','7.1: obvod obdélníku $=2\\cdot(18+8)=52\\ \\mathrm{cm}$. Lichoběžník má výšku $8\\ \\mathrm{cm}$ a obě ramena $10\\ \\mathrm{cm}$; součet obou rovnoběžných stran $=\\frac{2\\cdot144}{8}=36\\ \\mathrm{cm}$, obvod $=36+2\\cdot10=56\\ \\mathrm{cm}$. Liší se o $56-52=4\\ \\mathrm{cm}$.'},
  '7.1: o $4\\ \\mathrm{cm}$; 7.2: $18\\ \\mathrm{cm}$; 7.3: $144\\ \\mathrm{cm}^2$',
  3, 6, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','bez-kalkulacky'},
  'M9PID18C0T01', 2018
);

System.debug('Vytvořeno úloh: '+c.created);
