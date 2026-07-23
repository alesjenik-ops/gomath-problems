String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD24C0T04';
Integer YEAR = 2024;

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
  'CERMAT M9D 2024 – úloha 12',
  new List<String>{'Petr přečetl již $1\\,050$ stran knižní série, do konce mu zbývá přečíst ještě $450$ stran.','Kolik procent stran knižní série Petrovi zbývá dočíst?'},
  new List<String>{'A) $27\\,\\%$','B) $30\\,\\%$','C) $33\\,\\%$','D) $40\\,\\%$','E) $43\\,\\%$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Celkem má série $1\\,050+450=1\\,500$ stran. Zbývá $\\frac{450}{1\\,500}=0{,}3=30\\,\\%$.'},
  'B) $30\\,\\%$',
  2, 3, '2',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2024 – úloha 13',
  new List<String>{'Maminka oškrabe $6$ kg brambor za $2$ hodiny a $24$ minut. Babička oškrabe $2$ kg brambor za $1$ hodinu a $20$ minut. Maminka i babička škrabou brambory stálým tempem.','Za kolik minut oškrabou maminka a babička $1$ kg brambor, pokud škrabou obě dohromady?'},
  new List<String>{'A) za $64$ minut','B) za $32$ minut','C) za $15$ minut','D) za $12$ minut','E) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Maminka: $6$ kg za $144$ minut, tj. $\\frac{6}{144}=\\frac{1}{24}$ kg za minutu. Babička: $2$ kg za $80$ minut, tj. $\\frac{2}{80}=\\frac{1}{40}$ kg za minutu. Dohromady $\\frac{1}{24}+\\frac{1}{40}=\\frac{5+3}{120}=\\frac{8}{120}=\\frac{1}{15}$ kg za minutu, tedy $1$ kg za $15$ minut.'},
  'C) za $15$ minut',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2024 – úloha 14',
  new List<String>{'Přímky $p$, $r$ a $s$ se protínají v jednom bodě (viz obrázek).','Jaký je součet úhlů $\\alpha+\\beta+\\gamma$? Velikosti úhlů neměřte, ale vypočítejte (obrázek je ilustrační).'},
  new List<String>{'A) $126^\\circ\\,30^\\prime$','B) $133^\\circ\\,30^\\prime$','C) $143^\\circ\\,30^\\prime$','D) $180^\\circ$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif"> <line x1="60" y1="150" x2="440" y2="150" stroke="#000" stroke-width="1.5"/> <text x="448" y="154" font-size="15" font-style="italic">p</text> <line x1="250" y1="35" x2="250" y2="275" stroke="#000" stroke-width="1.5"/> <text x="242" y="30" font-size="15" font-style="italic">s</text> <line x1="161" y1="271" x2="339" y2="29" stroke="#000" stroke-width="1.5"/> <text x="344" y="26" font-size="15" font-style="italic">r</text> <path d="M250,150 L263,150 L263,163 L250,163" fill="none" stroke="#000" stroke-width="1"/> <text x="200" y="96" font-size="14">126°30′</text> <text x="298" y="142" font-size="15">γ</text> <text x="203" y="171" font-size="15">α</text> <text x="232" y="206" font-size="15">β</text> </svg>',
  'primky-uhly.svg',
  'Tri primky p, r, s prochazejici jednim bodem; vyznacen uhel 126 stupnu 30 minut, pravy uhel a uhly alfa, beta, gama.',
  'Schematický nákres (obrázek je ilustrační)',
  new List<String>{'Přímky $p$ a $s$ jsou kolmé (vyznačený pravý úhel), svírají $90^\\circ$. Úhel $\\gamma$ doplňuje vyznačený úhel do přímého úhlu: $\\gamma=180^\\circ-126^\\circ\\,30^\\prime=53^\\circ\\,30^\\prime$. Úhel $\\alpha$ je vrcholový k úhlu $\\gamma$, tedy $\\alpha=53^\\circ\\,30^\\prime$. Úhel $\\beta$ doplňuje $\\alpha$ do pravého úhlu: $\\beta=90^\\circ-53^\\circ\\,30^\\prime=36^\\circ\\,30^\\prime$. Součet $\\alpha+\\beta+\\gamma=53^\\circ\\,30^\\prime+36^\\circ\\,30^\\prime+53^\\circ\\,30^\\prime=143^\\circ\\,30^\\prime$.'},
  'C) $143^\\circ\\,30^\\prime$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
