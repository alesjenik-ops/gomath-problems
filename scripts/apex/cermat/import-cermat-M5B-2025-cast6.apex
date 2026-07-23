String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD25C0T02';
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
  'CERMAT M5B 2025 - uloha 11',
  new List<String>{'Zahon ma tvar rovnostranneho trojuhelniku. Cely zahon je osazen zlute a fialove kvetoucimi rostlinami, a to ve stejnych rozestupech. Po jedne rostline je i v kazdem vrcholu trojuhelniku. Ze vsech rostlin na zahone je $39$ rostlin rozmisteno po obvodu zahonu.','Zlute kvetouci rostliny vytvareji v zahonu $6$ stejnych zlutych rovnostrannych trojuhelniku. Fialove kvetouci rostliny tvori $3$ fialove rovnostranne trojuhelniky. Kazdy fialovy trojuhelnik ma o $1$ radu rostlin vice nez zluty trojuhelnik.','Kolik fialove kvetoucich rostlin je vysazeno na celem zahonu?'},
  new List<String>{'A) $36$ rostlin','B) $45$ rostlin','C) $48$ rostlin','D) $51$ rostlin','E) vice nez $51$ rostlin'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 240" font-family="sans-serif"><polygon points="160,40 126.7,96.7 193.3,96.7" fill="#e6e6e6" stroke="#000"/><polygon points="126.7,96.7 93.3,153.3 160.0,153.3" fill="#e6e6e6" stroke="#000"/><polygon points="193.3,96.7 160.0,153.3 226.7,153.3" fill="#e6e6e6" stroke="#000"/><polygon points="93.3,153.3 60,210 126.7,210.0" fill="#e6e6e6" stroke="#000"/><polygon points="160.0,153.3 126.7,210.0 193.3,210.0" fill="#e6e6e6" stroke="#000"/><polygon points="226.7,153.3 193.3,210.0 260,210" fill="#e6e6e6" stroke="#000"/><polygon points="126.7,96.7 193.3,96.7 160.0,153.3" fill="#8f8f8f" stroke="#000"/><polygon points="93.3,153.3 160.0,153.3 126.7,210.0" fill="#8f8f8f" stroke="#000"/><polygon points="160.0,153.3 226.7,153.3 193.3,210.0" fill="#8f8f8f" stroke="#000"/><text x="150" y="234" font-size="11" text-anchor="middle" fill="#555">6 zlutych (svetle) a 3 fialove (tmave) trojuhelniky - schematicky</text></svg>',
  'zahon-11.svg',
  'Rovnostranny trojuhelnikovy zahon rozdeleny na mensi zlute a fialove rovnostranne trojuhelniky.',
  'Rozmisteni trojuhelniku na zahone (schematicky nakres)',
  new List<String>{'Fialovy trojuhelnik ma o jednu radu vice nez zluty, tj. $5$ rostlin na strane ($4$ rozestupy): $\\frac{5\\cdot 6}{2}=15$ rostlin. Fialove trojuhelniky jsou $3$, dohromady $3\\cdot 15=45$ rostlin. Kontrola: $6\\cdot 10+3\\cdot 15=60+45=105$ rostlin.'},
  'B) $45$ rostlin',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2025 - uloha 12',
  new List<String>{'Ve stavebnici jsou dva druhy kostek - krychle (K) a hranol (H), ktery lze slozit ze dvou krychli. Adam a Marek postavili ze stavebnice dva stejne velke kvadry (viz obrazek). Zatimco Adam pouzil jen hranoly, Markuv kvadr obsahuje jak hranoly, tak krychle.','Jaky je nejvetsi mozny pocet hranolu (H) v kvadru, ktery postavil Marek?'},
  new List<String>{'A) $2$ hranoly','B) $6$ hranolu','C) $7$ hranolu','D) $8$ hranolu','E) jiny pocet hranolu'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 170" font-family="sans-serif"> <rect x="40" y="40" width="30" height="30" fill="#e8e8e8" stroke="#000"/> <text x="55" y="90" font-size="12" text-anchor="middle">K</text> <rect x="110" y="25" width="30" height="45" fill="#e8e8e8" stroke="#000"/> <text x="125" y="90" font-size="12" text-anchor="middle">H</text> <text x="330" y="45" font-size="12" text-anchor="middle">Adamuv a Markuv kvadr jsou stejne velke kvadry.</text> <text x="330" y="68" font-size="11" text-anchor="middle" fill="#666">Adam pouzil jen hranoly (H), Markuv kvadr obsahuje hranoly i krychle (K).</text> <text x="260" y="125" font-size="11" text-anchor="middle" fill="#666">Prostorova telesa jsou zde jen schematicka; posuzuje se podle testoveho sesitu.</text> </svg>',
  'stavebnice.svg',
  'Krychle K, hranol H slozeny ze dvou krychli a dva stejne velke kvadry Adama a Marka (schematicky).',
  'Stavebnice - krychle a hranoly (schematicky nakres)',
  new List<String>{'Adamuv kvadr je slozen jen z hranolu, jeho objem odpovida $18$ krychlim (kvadr $3\\times 3\\times 2$ krychle), tedy $9$ hranolu. Markuv kvadr ma stejny objem $18$ krychli a musi obsahovat aspon jednu krychli. Objem $18$ je sudy, takze krychli musi byt sudy pocet, nejmene $2$; zbytek tvori hranoly: $\\frac{18-2}{2}=8$ hranolu. Nejvetsi mozny pocet hranolu je $8$.'},
  'D) $8$ hranolu',
  2, 5, '4',
  new List<String>{'zs1','stereometrie','porozumeni','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
