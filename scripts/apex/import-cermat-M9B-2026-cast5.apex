String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. řádný termín (M9B)';
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
  'CERMAT 2026 M9B · úloha 11',
  new List<String>{'Na parkovišti mohou auta stát jeden den nebo zůstat zaparkovaná nepřetržitě více dnů. Na noc se parkoviště pro vjezd a výjezd uzavírá. V grafu jsou znázorněny počty aut na parkovišti v průběhu pěti dnů, čtyři údaje však chybí.','Např. v pátek bylo na parkovišti již před otevřením $9$ aut, která tam zůstala z předchozích dnů, během dne pak přibylo $12$ nově zaparkovaných aut. Z těchto $21$ aut v pátek $3$ auta ukončila parkování a odjela.','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','11.1 V pondělí bylo na parkovišti již před otevřením právě $10$ aut.','11.2 Ve středu na parkovišti nově zaparkovalo $9$ aut.','11.3 Ve čtvrtek ukončilo parkování méně než $12$ aut.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 551 320"><path d="M4 4L458 4L458 316L4 316ZM57 226L57 17M53 226L57 226M53 203L57 203M53 180L57 180M53 157L57 157M53 133L57 133M53 110L57 110M53 87L57 87M53 64L57 64M53 41L57 41M53 18L57 18M57 133L447 133M57 130L57 137M135 130L135 137M213 130L213 137M291 130L291 137M369 130L369 137M447 130L447 137" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M57 214L447 214M57 191L447 191M57 168L447 168M57 145L447 145M57 122L447 122M57 99L447 99M57 76L447 76M57 52L447 52M57 29L447 29" style="fill:none;stroke:#d9d9d9;stroke-width:1"/><path d="M57 226L447 226M57 203L447 203M57 180L447 180M57 157L447 157M57 110L447 110M57 87L447 87M57 64L447 64M57 41L447 41M57 18L447 18M135 17L135 226M213 17L213 226M291 17L291 226M369 17L369 226M447 17L447 226" style="fill:none;stroke:#bfbfbf;stroke-width:1"/><path d="M69 16L84 16L84 133L69 133Z" style="fill:#ffffff;stroke:#000000;stroke-width:1"/><path d="M146 41L161 41L161 133L146 133Z" style="fill:#969696;stroke:#000000;stroke-width:1"/><path d="M224 16L239 16L239 133L224 133Z" style="fill:#ffffff;stroke:#000000;stroke-width:1"/><path d="M302 41L317 41L317 133L302 133ZM380 81L395 81L395 133L380 133Z" style="fill:#969696;stroke:#000000;stroke-width:1"/><path d="M244 16L259 16L259 133L244 133Z" style="fill:#ffffff;stroke:#000000;stroke-width:1"/><path d="M89 52L104 52L104 133L89 133ZM166 110L181 110L181 133L166 133ZM322 104L337 104L337 133L322 133ZM400 64L415 64L415 133L400 133Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:1"/><path d="M342 133L357 133L357 227L342 227Z" style="fill:#ffffff;stroke:#000000;stroke-width:1"/><path d="M109 133L124 133L124 157L109 157ZM187 133L202 133L202 174L187 174ZM264 133L279 133L279 168L264 168ZM420 133L435 133L435 151L420 151Z" style="fill:#000000;stroke:#000000;stroke-width:1"/><path d="M100 255L110 255L110 265L100 265Z" style="fill:#969696;stroke:#000000;stroke-width:1"/><path d="M100 275L110 275L110 285L100 285Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:1"/><path d="M100 295L110 295L110 305L100 305Z" style="fill:#000000;stroke:#000000;stroke-width:1"/><text x="40" y="232" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">16</text><text x="40" y="208" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">12</text><text x="43" y="185" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8</text><text x="43" y="162" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4</text><text x="43" y="139" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">0</text><text x="43" y="116" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4</text><text x="43" y="93" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8</text><text x="40" y="70" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">12</text><text x="40" y="47" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">16</text><text x="40" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">20</text><text x="96" y="243" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Pondělí</text><text x="174" y="243" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Úterý</text><text x="252" y="243" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Středa</text><text x="330" y="243" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Čtvrtek</text><text x="408" y="243" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Pátek</text><text x="25" y="144" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Počet aut</text><text x="241" y="266" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Auta, která na parkovišti zůstala z předchozích dnů</text><text x="173" y="286" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Nově zaparkovaná auta</text><text x="241" y="306" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Auta, která během dne ukončila parkování a odjela</text></svg>',
  'obr.svg',
  'Sloupcový graf počtu aut na parkovišti během pěti dnů (pondělí–pátek) se třemi kategoriemi: auta z předchozích dnů, nově zaparkovaná a odjíždějící; čtyři údaje chybí.',
  '',
  new List<String>{'Počet aut zůstávajících na další den $=$ (auta z předchozích dnů) $+$ (nově zaparkovaná) $-$ (odjetá).','11.1: v pondělí nemohla být žádná auta z předchozích dnů (jde o první den), tvrzení je nepravdivé — N.','11.2: ve středu nově zaparkovalo $9$ aut — A.','11.3: ve čtvrtek ukončilo parkování $12$ aut, nikoli méně — N.'},
  '11.1: N; 11.2: A; 11.3: N',
  4, 5, '3',
  new List<String>{'zs2','r9','statistika','porozumeni','slovni','bezny-zivot'},
  'M9PBD26C0T02', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
