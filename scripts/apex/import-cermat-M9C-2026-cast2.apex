String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 1. náhradní termín (M9C)';
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
  'CERMAT 2026 M9C · úloha 6',
  new List<String>{'První šestiúhelník se skládá ze dvou shodných bílých rovnostranných trojúhelníků a dvou shodných šedých trojúhelníků. Trojúhelníky přeskládáme do druhého šestiúhelníku (viz obrázek). Nejdelší strana šedého trojúhelníku měří $10\\ \\mathrm{cm}$. Obvod prvního šestiúhelníku je $40\\ \\mathrm{cm}$ a obvod druhého šestiúhelníku je $46\\ \\mathrm{cm}$.','6.1 Určete v cm délku jedné strany bílého rovnostranného trojúhelníku.','6.2 Určete v cm obvod šedého trojúhelníku.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 155"><path d="M455 4L456 4L456 20L455 20Z" style="fill:#000000"/><path d="M455 20L456 20L456 39L455 39Z" style="fill:#000000"/><path d="M455 39L456 39L456 151L455 151Z" style="fill:#000000"/><path d="M49 128L4 102L49 76L49 128M88 121L133 95L88 69L88 121M245 121L199 95L245 69L245 121M245 121L290 95L245 69L245 121" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M49 128L88 69L49 76L49 128Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><path d="M60 104L54 100L54 100L54 102L54 101L54 99L54 99L61 103L60 104M57 94C57 93 58 93 59 93C60 93 61 93 62 94C63 95 64 96 64 96C64 97 64 98 64 99C63 99 63 100 62 100C61 100 60 99 59 99C58 98 57 97 57 96C56 96 57 95 57 94M58 95C57 95 57 95 58 96C58 97 59 97 60 98C60 98 61 99 62 99C62 99 63 99 63 98C63 98 63 97 63 97C63 96 62 96 61 95C60 94 60 94 59 94C58 94 58 94 58 95M68 89L69 89C69 90 69 90 69 90C69 90 69 91 69 91C68 92 67 92 67 92C66 93 65 92 64 92C64 91 63 91 63 90C63 89 63 88 64 88C64 87 64 87 65 87L65 87C65 87 65 88 64 88C64 89 64 89 64 90C64 90 65 91 65 91C66 91 66 91 67 91C67 91 68 91 68 90C68 90 68 90 68 89M70 89L67 86C66 86 66 86 65 85L66 85L66 85L66 85C66 84 66 84 67 83C67 83 67 82 67 82C68 82 68 82 68 82L68 82C68 82 68 82 68 81C68 81 68 80 69 80C69 80 69 80 69 80C69 79 69 79 69 79C70 79 70 79 70 79C70 79 70 79 71 79C71 79 71 80 72 80L75 82L74 82L71 81C71 80 70 80 70 80C70 80 69 80 69 81C69 81 69 81 69 82C69 82 69 82 69 82C69 82 69 83 70 83L73 85L72 86L69 84C69 83 68 83 68 83C68 83 67 83 67 84C67 84 67 84 67 85C67 85 67 85 67 85C67 86 68 86 68 86L71 88L70 89Z" style="fill:#000000"/><path d="M88 69L49 128L88 121L88 69Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><path d="M197 136L197 129L197 129L196 130L195 129L197 128L198 128L198 136L197 136M203 127C204 127 205 128 205 128C206 129 206 130 206 131C206 132 206 134 206 134C205 135 204 135 204 135C203 135 202 135 202 134C201 134 201 133 201 132C201 130 201 129 201 129C202 128 202 127 203 127M203 128C203 128 202 129 202 129C202 130 202 130 202 132C202 133 202 133 202 134C203 134 203 135 204 135C204 135 204 134 205 134C205 133 205 132 205 131C205 130 205 130 204 129C204 128 204 128 203 128M214 134L214 135C214 135 214 135 214 135C213 135 213 135 213 135C212 135 211 135 210 134C210 134 210 133 209 132C209 131 210 130 210 130C211 129 212 129 212 129C213 129 214 129 214 129L214 130C213 130 213 130 212 130C212 130 211 130 211 130C211 131 211 131 211 132C211 133 211 133 211 134C212 134 212 134 213 134C213 134 214 134 214 134M215 135L215 130C215 130 215 129 215 129L216 129L216 130L216 130C217 129 217 129 218 129C218 129 219 129 219 129C219 129 219 129 220 130L220 130C220 129 220 129 220 129C221 129 221 128 222 128C222 128 222 128 222 128C222 128 222 129 223 129C223 129 223 129 223 129C223 129 223 130 223 130C223 130 224 130 224 131L224 134L223 134L223 131C222 130 222 130 222 130C222 129 222 129 221 129C221 129 221 129 220 130C220 130 220 130 220 130C220 131 220 131 220 131L220 134L219 134L219 131C219 131 219 130 219 130C218 130 218 129 218 129C217 130 217 130 217 130C217 130 216 130 216 131C216 131 216 131 216 131L216 135L215 135Z" style="fill:#000000"/><path d="M267 134L268 127L268 127L266 128L266 127L268 126L269 126L268 134L267 134M274 127C275 127 276 127 276 128C276 128 277 129 277 131C277 132 276 133 276 134C275 134 275 135 274 135C273 135 272 134 272 133C271 133 271 132 271 130C271 129 272 128 272 127C273 127 273 126 274 127M274 127C274 127 273 128 273 128C273 129 272 129 272 130C272 132 272 132 273 133C273 133 273 134 274 134C274 134 275 134 275 133C275 132 275 132 276 131C276 130 276 129 275 128C275 128 275 127 274 127M284 134L284 135C284 135 284 135 284 135C283 135 283 135 283 135C282 135 281 135 281 134C280 134 280 133 280 132C280 131 280 130 281 130C281 129 282 129 283 129C284 129 284 129 285 129L284 130C284 130 284 130 283 130C282 130 282 130 282 130C281 131 281 131 281 132C281 133 281 133 281 134C282 134 282 134 283 134C283 134 284 134 284 134M286 135L286 131C286 130 286 130 286 129L287 129L287 130L287 130C287 130 288 129 289 129C289 129 289 129 290 130C290 130 290 130 290 131L290 131C290 130 291 130 291 130C291 130 292 129 292 129C292 129 293 129 293 130C293 130 293 130 293 130C293 130 294 130 294 130C294 130 294 131 294 131C294 131 294 132 294 132L294 135L293 135L293 132C293 132 293 131 293 131C293 130 292 130 292 130C292 130 291 130 291 131C291 131 291 131 291 131C290 131 290 132 290 132L290 135L289 135L289 132C289 131 289 131 289 131C289 130 289 130 288 130C288 130 288 130 287 130C287 131 287 131 287 131C287 131 287 131 287 132L287 135L286 135Z" style="fill:#000000"/><path d="M245 121L174 125L199 95L245 121Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><path d="M245 121L315 124L290 95L245 121Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><text x="162" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Trojúhelníky přeskládáme do druhého šestiúhelníku (viz obrázek).</text><text x="70" y="62" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1. šestiúhelník</text><text x="246" y="62" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. šestiúhelník</text></svg>',
  'obr.svg',
  'Dva shodné bílé rovnostranné trojúhelníky a dva shodné šedé trojúhelníky přeskládané ze prvního do druhého šestiúhelníku.',
  '',
  new List<String>{'Označíme stranu bílého rovnostranného trojúhelníku $w$ a strany šedého trojúhelníku (nejdelší $10\\ \\mathrm{cm}$).','Z obvodů obou šestiúhelníků ($40\\ \\mathrm{cm}$ a $46\\ \\mathrm{cm}$) a délky nejdelší strany šedého trojúhelníku vychází $w=7\\ \\mathrm{cm}$.','Obvod šedého trojúhelníku je pak $23\\ \\mathrm{cm}$.'},
  '6.1: $7\\ \\mathrm{cm}$; 6.2: $23\\ \\mathrm{cm}$',
  3, 5, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD26C0T03', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
